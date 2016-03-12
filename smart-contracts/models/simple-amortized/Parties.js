// Copyright (c) 2016, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License

"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define(function() {
    function.set(obj) {
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
		name : "Banzai Institute for Biomedical Engineering and Strategic Information Limited",
		domicile : "Hong Kong",
		company_number : "2334455",
		registered_office : "3/F, Citicorp Centre, 18 Whitfield Road, Tin Hau, Hong Kong",
		contact : {
		    name: "Dr. Buckaroo Banzai",
		    address: "Banzai Institute, 1 Banzai Road, Holland Township, New Jersey",
		    email: "buckaroo@example.com"
		}
	    }
	};
    }
});
