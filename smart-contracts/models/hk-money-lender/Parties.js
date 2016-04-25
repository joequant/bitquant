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
		type: "corporation",
		name : "Yoyodyne Propulsion Systems Limited",
		domicile : "Hong Kong",
		company_number : "1234552",
		registered_office : "3/F, Nam Wo Hong Building, 148 Wing Lok Street, Sheung Wan, Hong Kong",
		contact : {
		    name: "John Bigboote",
		    address: "Yoyodyne Propulsion Systems, 1938 Cranbury Road, Grovers Mills, New Jersey",
		    email: "bigboote@example.com"
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
