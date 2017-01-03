"use strict";
class Viewer {
    constructor(schedule, terms) {
	this.schedule = schedule;
	this.terms = terms;
    }
    add_item(name, value, type) {
	var field_value = "value='" +  value + "'";
	if (type === "checkbox") {
	    if (value === true) {
		field_value = "checked";
	    } else {
		field_value = "";
	    }
	} else if (type == 'money') {
	    field_value = "value='" +  value[1] + "'";
	    var r =
		`<input id='${name}' name='${name}' type='number' ${field_value} /> (${value[0]})`;
	    return r;
	} else if (type == 'percent') {
	    type = "number";
	}
	
	var r = 
	    `<input id='${name}' name='${name}' type='${type}' ${field_value} />`;
	return r;
    }

    read_inputs(prefix, suffix, inputs, values) {
	inputs.forEach(function(y) {
	    var id = `#${prefix}_${y.name}_${suffix}`;
	    if (y.type == "checkbox") {
		values[y.name] = $(id).prop('checked');
		return;
	    }
	    if (y.type == "money" || y.type == "percent" ||
		y.type == "number") {
		var value = $(id).val();
		if (value !== undefined && value !== "") {
		    values[y.name] = Number(value);
		}
		return;
	    }
	    values[y.name] = $(id).val();
	});
    }
    
    handle_click() {
	var inputs = {};
	var terms = {};
	this.read_inputs(this.schedule.name, 'input', this.schedule.inputs,
			 inputs);
	this.read_inputs(this.schedule.name, 'term', this.schedule.terms,
			 terms);
	var outputs = this.schedule.calculate(inputs, terms);
	var html = "";
	this.schedule.outputs.forEach(function(y) {
	    html += `${y.display}: ${outputs[y.name]}<br>`;
	});
	document.getElementById(this.schedule.name + "_output").innerHTML = html;
    }
    
    generate_inputs(plist, prefix, suffix, values) {
	var input = "";
	var o = this;
	plist.forEach(function(y) {
	    var value = "";
	    if (values[y.name] != undefined) {
		value = values[y.name];
	    }
	    input += `${y.display}:
	    ${o.add_item(prefix + "_" + y.name + "_" + suffix,
			 value, y.type)}<br>`;
	});
	return input;
    }
    
    view(div) {
	var o = this;
	var html = `<h3>${this.schedule.display}</h3>
	    ${this.schedule.description}<p>
	    <b>Contract terms</b><br>
	    ${this.generate_inputs(this.schedule.terms, this.schedule.name,
				   'term', this.terms)}
	    <b>Inputs</b><br>
	    ${this.generate_inputs(this.schedule.inputs, this.schedule.name,
				   'input', {})}
	    <br>
	    <button id='${this.schedule.name + "_recalc"}' type="button">Recalculate</button>
	    <div id='${this.schedule.name + "_output"}'></div>`;
	$(div).append(html);
	$(`#${this.schedule.name}_recalc`).click(function() {o.handle_click();});
    }
};

var converter = new showdown.Converter();
function show_text(div, contract) {
    var source = contract.template;
    var terms = contract.terms;
    var terms_display = {};
    for(var key in terms) {
	if(terms.hasOwnProperty(key)) {
	    if (terms[key].constructor == Array) {
		terms_display[key] =
		    terms[key].map(function(x) {return
						x.toString().replace("_", " ")}).join(" ");
	    } else {
		terms_display[key] = terms[key];
	    }
	}
    }
    var template = Handlebars.compile(source);
    $(div).html(converter.makeHtml(template(terms_display)));
}

function show_schedules(div, contract) {
    $(div).empty();
    contract.schedules.forEach(function(x) {
	var s = new Viewer(x, contract.terms);
	s.view(div);
    });
}
