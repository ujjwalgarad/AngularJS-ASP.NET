(function () {
    'use strict';
    var app = angular.module('appCMClass');

    app.service('SrvData', function ($http) {

       
        
        this.searchMatters = function (clientNumber, matterSrchKey) {
            debugger;
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/SearchMatters',
                params: { clientNumber: clientNumber, matterSrchKey: matterSrchKey },
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.getClientMatters = function (clientNumber, matterNumber) {
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/GetClientMatters',
                params: { clientNumber : clientNumber, matterNumber: matterNumber },
                headers: { 'Content-Type': 'application/json' }
            });
        };
        
        this.getAllPoolsAndBadges = function () {
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/GetAllPoolsAndBadges',
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.getAllPoolsAndBadges = function () {
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/GetAllPoolsAndBadges',
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.updateBadgeName = function (itemId, itemName) {
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/UpdateBadgeName',
                params: { itemId: itemId, itemName: itemName },
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.addBadge2Lib = function (badge) {
            debugger;
            //var input = $.param({ badge: JSON.stringify(badge) });
            //console.log(input);
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/AddBadge2Lib',
                //data: input,
                params: { badge: badge},
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            });
        };

        this.attachBadge = function (miniBadge) {
            debugger;
            //var input = $.param({ badge: JSON.stringify(badge) });
            //console.log(input);
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/AttachBadge',
                //data: input,
                params: { miniBadge: miniBadge },
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            });
        };

        this.detachBadge = function (cmBadgeId) {
            debugger;
            //var input = $.param({ badge: JSON.stringify(badge) });
            //console.log(input);
            return $http(
            {
                method: 'GET',
                url: 'wsServices/wSrvTools.asmx/DetachBadge',
                //data: input,
                params: { cmBadgeId: cmBadgeId },
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            });
        };

        this.getMatchingClients = function (clientSrchCriteria,techSrchCriteria,sectorSrchCriteria) {
            debugger;
            var input = $.param({ clientSrchCriteria: JSON.stringify(clientSrchCriteria), techSrchCriteria: JSON.stringify(techSrchCriteria), sectorSrchCriteria: JSON.stringify(sectorSrchCriteria) });
            return $http({
                method: 'Post',
                url: 'wsServices/wSrvTools.asmx/GetMatchingClients',
                data: input,
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            });
        };

    });

}());