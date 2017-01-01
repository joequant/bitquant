var calculate = function(div, schedules) {
    var html = "";
    schedules.forEach(function(x) {
	var input = "";
	x.inputs.forEach(function(y) {
	    input += `${y.display}: <br>`;
	});
	x.parameters.forEach(function(y) {
	    input += `${y.display}: <br>`;
	});
	html += `<h3>${x.display}</h3>
${x.description}<p>
${input}<br>
<button id='${x.name + "_recalc"}' type="button">Recalculate</button>
<div id='${x.name + "_output"}'></div>`;
    });
    div.innerHTML = html;
}
