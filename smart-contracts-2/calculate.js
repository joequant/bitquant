function add_item(name, value, type) {
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

var schedule_store = {};

function read_inputs(prefix, suffix, inputs, values) {
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

function handle_click(schedule_name) {
    var inputs = {};
    var terms = {};
    var x = schedule_store[schedule_name];
    read_inputs(schedule_name, 'input', x.inputs, inputs);
    read_inputs(schedule_name, 'term', x.terms, terms);
    var outputs = x.calculate(inputs, terms);
    var html = "";
    x.outputs.forEach(function(y) {
	html += `${y.display}: ${outputs[y.name]}<br>`;
    });
    document.getElementById(schedule_name + "_output").innerHTML = html;
}

function generate_inputs(plist, prefix, suffix, values) {
    var input = "";

    plist.forEach(function(y) {
	var value = "";
	if (values[y.name] != undefined) {
	    value = values[y.name];
	}
	input += `${y.display}:
	${add_item(prefix + "_" + y.name + "_" + suffix, value, y.type)}<br>`;
    });
    return input;
}

function calculate(div, schedules, terms) {
    var html = "";
    schedules.forEach(function(x) {
	schedule_store[x.name] = x;
	html += `<h3>${x.display}</h3>
	    ${x.description}<p>
	    <b>Contract terms</b><br>
	    ${generate_inputs(x.terms, x.name, 'term', terms)}
	<b>Inputs</b><br>
	    ${generate_inputs(x.inputs, x.name, 'input', {})}
	<br>
<button id='${x.name + "_recalc"}' type="button" onclick='handle_click("${x.name}")'>Recalculate</button>
<div id='${x.name + "_output"}'></div>`;
    });
    div.innerHTML = html;
}
