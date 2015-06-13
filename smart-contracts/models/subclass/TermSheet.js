// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License

"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}


define(["../loan/TermSheet"], function(TermSheet) {
    function SubClass() {
	TermSheet.call(this);
	this.borrower.name = "TEST CHANGE";
    }
    SubClass.prototype = Object.create(TermSheet.prototype);
    return SubClass;
});
