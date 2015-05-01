// Copyright (c) 2015, Bitquant Research Laboratories (Asia) Limited
// Licensed under the Simplified BSD License

"use strict";
if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define([], function() {
function load_analyzer(term_sheet, notes, callback) {
require.config({
    paths: {
        "moment": "node_modules/moment/moment",
	"jquery" : "http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min",
	"modernizr" : "http://cdn.jsdelivr.net/webshim/1.14.2/extras/modernizr-custom",
	"jquery-ui" : "http://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min",
	"append-grid" :  "jquery.appendGrid-1.5.0.min",
	"polyfiller" :    "http://cdn.jsdelivr.net/webshim/1.14.2/polyfiller",
	"markdown" :
    "http://cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.min",
	"collapse" : "jquery.collapse",
	"handlebars" : "https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.0/handlebars.min"
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
    "./Calculator",
    notes,
    "handlebars",
    "markdown",
    "append-grid",
    "polyfiller",
    "collapse"], function(TermSheet, Calculator, Notes,
			 Handlebars) {
    webshims.setOptions('forms-ext', {types: 'date'});
    var converter = new Markdown.Converter();
    var my_term_sheet = new TermSheet();
    var my_notes = new Notes();
    var template = Handlebars.compile(my_term_sheet.contract_text);
    $("#text").html(converter.makeHtml(template(my_term_sheet)));
    $("#text").collapse({query: 'h2'});
    var local_report = function(payment_schedule,
				  calculator,
				  process_payment,
				  output) {
	try {
	    output.html("");
	    output.html("<table><tr>");
	    output.append("<td>event</td>");
	    output.append("<td>date</td>");
	    output.append("<td>principal</td>");
	    output.append("<td>interest</td>");
	    output.append("<td>balance</td>");
	    output.append("<td>late balance</td>");
	    output.append("<td>principal payment</td>");
	    output.append("<td>interest payment</td>");
	    output.append("</tr>");

	    payment_schedule.forEach(function(i) {
		my_term_sheet.process_payment(i);
		var note = "";
		if (i.note != undefined) {
		    note = i.note;
		}
		output.append("<tr><td>" +
				i.event + "</td><td>" +
				i.on.toDateString() + "</td><td class='number'>" +
				Number(i.principal).toFixed(2) +
	"</td><td class='number'>" +
				Number(i.interest_accrued).toFixed(2)
				+ "</td><td class='number'>" +
				Number(i.balance).toFixed(2)
				+ "</td><td class='number'>" +
				Number(i.late_balance).toFixed(2)
				+ "</td><td class='number'>" +
				Number(i.principal_payment).toFixed(2)
				+ "</td><td class='number'>" +
				Number(i.interest_payment).toFixed(2)
				+ "</td><td>" +
				note + "</td></tr>");


	    });
	    output.append("</table><br><br>");
	    output.append("Annual interest rate: " +
			      calculator.apr(payment_schedule).toFixed(4) + 
			      " percent");

	} catch(err) {
	    output.html(err.message);
	}
    };
    analyze = function() {
        var events = {
	};
	var params = {
	}
	my_term_sheet.event_spec.forEach(function(i) {
	    if (i.type == "grid") {
		var name = "#" + i.name + "_grid";
		events[i.name] = [];

		$(name).appendGrid('getAllValue').forEach(function(j) {
		    events[i.name].push(j);
		});
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
	    }
	    var value = $("#" + i.name + "_scenario").val();
	    if (value !== undefined && value !== "") {
		params[i.name] = value;
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
    callback(analyze);
    $(function() {
        my_term_sheet.contract_parameters.forEach(function(i) {
	    var display = i.display;
	    var div = "#contract_params";
            if (i.type == "note") {
		var template = Handlebars.compile(my_notes[i.name]);
		$(div).append(converter.makeHtml(template(my_term_sheet)));
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
	    } else {
		if (i.type == "date") {
			$(div).append(display + ": " +
					     my_term_sheet[i.name].toDateString());

		    } else {
			$(div).append(display + ": " +
					     my_term_sheet[i.name]);
		    }
		if (my_notes[i.name] != undefined) {
		    $(div).append(" - ");
		    $(div).append(my_notes[i.name]);
		}
		if (i.scenario == true) {
		    $(div).append("- <input id='" + i.name + "_scenario' name='" +
				  i.name + "_scenario' type='" + i.type + "'/>");
		}
		$(div).append("<br>");
	    }
	});

	my_term_sheet.event_spec.forEach(function(i) {
	    var div = "#event_inputs";
            if (i.type == "note") {
		var template = Handlebars.compile(my_notes[i.name]);
		$(div).append(converter.makeHtml(template(my_term_sheet)));
            } else if (i.type == "grid") {
		var table = document.createElement('table');
		var name = i.name + "_grid";
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
	    }
	});
	webshims.polyfill('forms forms-ext es5');
    });
});
};
return load_analyzer;
});
