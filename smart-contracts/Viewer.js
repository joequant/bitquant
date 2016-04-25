// Copyright (c) 2015, Bitquant Research Laboratories (Asia) Limited
// Licensed under the Simplified BSD License

"use strict";
if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define([], function() {
    function load_viewer(term_sheet, notes, callback, errback) {
require.config({
    paths: {
        "moment": "node_modules/moment/min/moment.min",
	"Calculator": "Calculator",
	"jquery" : "http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min",
	"modernizr" : "https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min",
	"jquery-ui" : "http://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min",
	"append-grid" :  "jquery.appendGrid-1.6.1.min",
	"polyfiller" :    "http://cdn.jsdelivr.net/webshim/1.15.10/polyfiller",
	"markdown" :
    "http://cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.min",
	"collapse" : "jquery.collapse",
	"handlebars" : "https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.3/handlebars.min"
    },
    shim: {
        "jquery-ui": {
            exports:"$" ,
            deps: ['jquery']
        },
	"markdown" : {
	    exports: "Markdown"
	},
        "append-grid": ['jquery-ui'],
        "collapse": ['jquery-ui'],
	"polyfiller" : {
	    exports: "webshims",
	    deps: ['modernizr']
	}
    },
    waitSeconds: 15
});
var analyze;




require ([
    term_sheet,
    "Calculator",
    notes,
    "handlebars",
    "moment",
    "markdown",
    "append-grid",
    "polyfiller",
    "collapse"], function(TermSheet, Calculator, Notes,
			 Handlebars,
			 moment) {

	function format_parties(t) {
	    Handlebars.registerHelper('toUpperCase', function(str) {
		return str.toUpperCase();
	    });
	    var templates = {
		"corporation" : (function() {/*
{{toUpperCase name}} incorporated and registered in {{domicile}} with company number {{company_number}} whose registered office is at {{registered_office}}{{extra}}
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1],
		"person" : (function() {/*
{{toUpperCase name}} a resident of {{domicile}} located at {{registered_office}}{{extra}}
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1]
	    };

	    var contact_template = (function() {/*
Address: {{address}}  
Email: {{email}}  
Attention: {{name}}  
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];

	    if (t.parties === undefined) {
		return;
	    }
	    t.parties_formatted = "";
	    t.contact_formatted = "";
	    t.parties.roles.forEach(function(role) {
		if (t.parties[role] !== undefined) {
		    var template = 
			Handlebars.compile(templates[t.parties[role].type]);
		    var compiled_contact_template =
			Handlebars.compile(contact_template);
		    t.parties_formatted = t.parties_formatted + 
			template(t.parties[role]) + " -- ('" + 
			role.toUpperCase() + "')  \n"; 
		    t.contact_formatted = t.contact_formatted + "the " + role.toUpperCase() + " at:  " + compiled_contact_template(t.parties[role].contact);
		}
	    });
	}
    webshims.setOptions('forms-ext', {types: 'date'});
    var converter = new Markdown.Converter();
    var my_term_sheet = new TermSheet();
    var my_notes = new Notes();
    var template = Handlebars.compile(my_term_sheet.contract_text);
    format_parties(my_term_sheet);
    $("#text").html(converter.makeHtml(template(my_term_sheet)));
    $("#text").collapse({query: 'h2'});
    var local_report = (function (payment_schedule,
                                     calculator,
                                     process_payment,
                                     output) {
	try {
	    var append_span = function(info) {
		output.append(info.join(" - "));
	    };
	    
	    output.html("");
	    output.append("<span class='block'>event</span> ");
	    output.append("<span class='date-block'>date</span> ");
	    output.append("<span class='block'>principal</span> ");
	    output.append("<span class='block'>fees</span> ");
	    output.append("<span class='block'>balance</span> ");
	    output.append("<span class='block'>late balance</span> ");
	    output.append("<span class='block'>principal payment</span> ");
	    output.append("<span class='block'>fee payment</span> ");
	    output.append("<span class='block'>total payment</span> ");
	    output.append("<br>");
	    
	    payment_schedule.forEach(function(i) {
		process_payment(i);
		var note = "";
		if (i.note != undefined) {
		    note = i.note;
		}
		if (i.event == "Note" ||
		    i.event == "Terminate" ||
		    i.event == "Action" ) {
		    output.append("<span class='block'>" +
				  i.event + "</span> ");
		    output.append("<span class='date-block'>" +
				  i.on.toDateString() + "</span> ");
		    output.append("<span>" +
				  note + "</span> ");
		    output.append("<br>");
		} else if (i.event ===  "Transfer" ||
			   i.event === "Obligation") {
		    var actual = i.actual;
		    if (actual === undefined) {
			actual = i.on;
		    }
		    var actor = i.from;
		    if (i.to !== undefined) {
			actor = actor + " -> " + i.to;
		    }
		    var list = [i.event,
				i.on.toDateString(),
				actor];
		    if (i.amount !== undefined) {
			list.push(Number(i.amount).toFixed(2));
		    }
		    if (i.item  !== undefined) {
			list.push(i.item);
		    }
		    if (i.note !== undefined) {
			list.push(i.note);
		    }
		    append_span(list);
		    output.append("<br>");
		} else {
		    output.append("<span class='block'>" +
				  i.event + "</span> <span class='date-block'>" +
				  i.on.toDateString() + "</span> <span class='number block'>" +
				  Number(i.principal).toFixed(2) +
				  "</span> <span class='number block'>" +
				  Number(i.interest_accrued).toFixed(2)
				  + "</span> <span class='number block'>" +
				  Number(i.balance).toFixed(2)
				  + "</span> <span class='number block'>" +
				  Number(i.late_balance).toFixed(2)
				  + "</span> <span class='number block'>" +
				  Number(i.principal_payment).toFixed(2)
				  + "</span> <span class='number block'>" +
				  Number(i.interest_payment).toFixed(2)
				  + "</span> <span class='number block'>" +
				  Number(i.interest_payment + 
					i.principal_payment).toFixed(2)
				  + "</span> <span> " +
				  note + "</span><br>");
		}
	    });
	    output.append("<br><br>Annual percentage rate:" + Number(calculator.apr(payment_schedule)).toFixed(4) + "<br>");
	    var myElements = document.querySelectorAll(".block");
	    
	    for (var i = 0; i < myElements.length; i++) {
		myElements[i].style.width = "80px";
		myElements[i].style.display = "inline-block";
	    }
	    
	    myElements = document.querySelectorAll(".date-block");
	    for (var i = 0; i < myElements.length; i++) {
		myElements[i].style.width = "150px";
		myElements[i].style.display = "inline-block";
	    }
	} catch (err) {
	    output.html(err.message);
	}
    });

    analyze = function() {
        var events = {
	};
	var params = {
	}
	my_term_sheet.event_spec.forEach(function(i) {
	    if (i.type == "grid") {
		var name = "#" + i.name + "_event";
		events[i.name] = [];

		$(name).appendGrid('getAllValue').forEach(function(j) {
		    events[i.name].push(j);
		});
	    } else if (i.type === "checkbox") {
		events[i.name] = $("#" + i.name + "_event").prop('checked');
	    } else if (i.type === "duration") {
		events[i.name] = $("#" + i.name + "_event").val().split(',');
	    } else {
		var value = $("#" + i.name + "_event").val();
		if (value !== undefined && value !== "") {
		    events[i.name] = value;
		}
	    }
	});

	my_term_sheet.contract_parameters.forEach(function(i) {
	    if (i.scenario !== true) {
		return;
	    }
	    if (i.type == "grid") {
		var name = "#" + i.name + "_scenario";
		params[i.name] = [];

		$(name).appendGrid('getAllValue').forEach(function(j) {
		    params[i.name].push(j);
		});
		return;
	    } else if (i.type === "checkbox") {
		params[i.name] = $("#" + i.name + "_scenario").prop('checked');
	    } else if (i.type === "duration") {
		params[i.name] = $("#" + i.name + "_scenario").val().split(',');
	    } else {
		var value = $("#" + i.name + "_scenario").val();
		if (value !== undefined && value !== "") {
		    params[i.name] = value;
		}
	    }
	});
	var calculator = new Calculator();
	calculator.set_events(my_term_sheet, events);
	calculator.set_parameters(my_term_sheet, params);

	var payment_schedule = calculator.calculate(my_term_sheet);
	if (my_notes.report !== undefined) {
	    my_notes.report(payment_schedule, 
			    calculator,
			    my_term_sheet.process_payment,
			    $('#item'));
	} else {
	    local_report(payment_schedule,
			 calculator,
			 my_term_sheet.process_payment,
			 $('#item'));
	}
    };

    function add_item(name, value, type) {
	var field_value = "value='" +  value + "'";
	if (type == "date") {
	    field_value = "value='" + moment(value).format("YYYY-MM-DD") + "'";
	} else if (type === "checkbox") {
	    if (value === true) {
		field_value = "checked";
	    } else {
		field_value = "";
	    }
	}
	return "<input id='" +  name +"' name='" +
	    name + "' type='" + type + "' " +
	    field_value + " />";
    }
    

    $(function() {
        my_term_sheet.contract_parameters.forEach(function(i) {
	    var display = i.display;
	    var div = "#contract_params";
	    if (i.target !== undefined) {
		div = "#" + i.target;
	    }
            if (i.type == "note") {
		var template = Handlebars.compile(my_notes[i.name]);
		$(div).append(converter.makeHtml(template(my_term_sheet)));
		$(div).collapse({query: 'h2'});
            } else if (i.type == "grid") {
		$(div).append("<br>" + i.display + "<br>");
		$(div).append("<table><tr>");
		i.columns.forEach(function(j) {
		    $(div).append("<td>" + j.display + "</td>");
		});
		$(div).append("</tr>");
		my_term_sheet[i.name].forEach(function(j) {
		    $(div).append("<tr>");
		    i.columns.forEach(function(k) {
			$(div).append("<td>" + j[k.name] + "</td>");
		    });
		    $(div).append("</tr>");
		});
	    } else if (i.type === "html")  {
		$(div).append(i.display);
	    } else {
		var value = my_term_sheet[i.name];
		if (i.type == "date") {
		    value = my_term_sheet[i.name].toDateString();
		}
		$(div).append(display + ": " + value);

		if (my_notes[i.name] != undefined) {
		    $(div).append(" - ");
		    $(div).append(my_notes[i.name]);
		}
		$(div).append(" - ");
		$(div).append(add_item(i.name + "_scenario",
				       value,
				       i.type));
		$(div).append("<br>");
	    }
	});

	my_term_sheet.event_spec.forEach(function(i) {
	    var div = "#event_inputs";
	    if (i.target !== undefined) {
		div = "#" + i.target;
	    }
            if (i.type == "note") {
		var template = Handlebars.compile(my_notes[i.name]);
		$(div).append(converter.makeHtml(template(my_term_sheet)));
		$(div).collapse({query: 'h2'});
            } else if (i.type == "grid") {
		var table = document.createElement('table');
		var name = i.name + "_event";
		table.id = name;
		$(div).append(table);
		$(table).appendGrid({
		     caption: i.display,
		     initRows: 0,
		     columns: i.columns,
		    afterRowInserted: function(caller,
					       parentRow,
					       addedRow) {
			$(caller).updatePolyfill();
		    },
		    afterRowAppended: function(caller,
					       parentRow,
					       addedRow) {
			$(caller).updatePolyfill();
		    }
		 });
	    } else if (i.type === "html") {
		$(div).append(i.display);
	    } else {
		$(div).append(i.display + ": ");
		if (my_notes[i.name] != undefined) {
		    $(div).append(" - ");
		    $(div).append(my_notes[i.name]);
		}
		$(div).append(add_item(i.name + "_event",
				       i.value,
				       i.type));
		$(div).append("<br>");
	    }
	});
	webshims.polyfill('forms forms-ext es5');
	callback(analyze);
    });
    },
	errback);
};
return load_viewer;
});
