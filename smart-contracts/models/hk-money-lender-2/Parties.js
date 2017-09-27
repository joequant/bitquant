// Copyright (c) 2016, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License

"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define(function() {
    return {"set" : function(obj) {
	obj.parties = {
	    roles : ["borrower", "lender"],
	    borrower : {
		type: "individual",
		name : "B1",
		domicile : "Hong Kong",
		address: "",
		extra: "",
		contact : {
		    name: "B1",
		    address: "A1",
		    email: "b1@a.com"
		}
	    },
	    lender:  {
		type: "corporation",
		name : "Bitquant Research Laboratories (Asia) Limited",
		domicile : "Hong Kong",
		company_number : "2022190",
		registered_office : "B-25, 3/F, Citicorp Centre, 18 Whitfield Road, Tin Hau, Hong Kong",
		contact : {
		    name: "Joseph Wang",
		    address: "B-25, 3/F, Citicorp Centre, 18 Whitfield Road, Tin Hau, Hong Kong",
		    email: "joequant@gmail.com"
		},
		extra : ", a licensed Hong Kong Money Lender with license 811/2015"
	    }
	};
    }
	   };
});
