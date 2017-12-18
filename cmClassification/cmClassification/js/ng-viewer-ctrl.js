(function () {
    'use strict';

    var app = angular.module("appCMClass");

    app.controller("ViewerCtrl", function ($scope, SrvData) {

        init();

        $scope.srchCriteria = [];
        $scope.searchResults = [];
        $scope.noResultsFound = false;

        function init() {
            // load all the tree nodes
            SrvData.getAllPoolsAndBadges().then(function (response) {

                if (response.data != null) {
                    debugger;
                    $scope.clientType = [{
                        name: 'Client Types',
                        children: response.data[0].Badges
                    }];

                    $scope.technologyType = [{
                        name: 'Technologies',
                        children: response.data[1].Badges
                    }];

                    $scope.sectorType = [{
                        name: 'Sectors',
                        children: response.data[2].Badges
                    }];
                }
                else {

                    alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                }
            }, function (err) {
                console.error("get referral form:", err);
            });
        };

        function findSelectedNodes(tree) {
            debugger;
            var selected = [];
            if (tree.selected != null) {
                tree.children.map(function (childL1) {
                    if (childL1.selected) {
                        selected.push(childL1.ItemId); //, name : childL1.name 
                    }
                    childL1.children.map(function (childL2) {
                        if (childL2.selected) {
                            selected.push(childL2.ItemId);
                        }
                        childL2.children.map(function (childL3) {
                            if (childL3.selected) {
                                selected.push(childL3.ItemId);
                            }
                        });
                    });
                });   
            }
            return selected;
        };
        
        $scope.onSubmit = function () {
            debugger;
            $scope.clientSrchCriteria = [];
            $scope.techSrchCriteria = [];
            $scope.sectorSrchCriteria = [];


            $scope.clientSrchCriteria = findSelectedNodes($scope.clientType[0]);
            $scope.techSrchCriteria = findSelectedNodes($scope.technologyType[0]);
            $scope.sectorSrchCriteria = findSelectedNodes($scope.sectorType[0]);
            //var temp = [];

            //temp = findSelectedNodes($scope.clientType[0]);
            //if(temp.length>0)
            //    $scope.srchCriteria.push(temp);

            //temp = findSelectedNodes($scope.technologyType[0]);
            //if (temp.length > 0)
            //    $scope.srchCriteria.push(temp);

            //temp = findSelectedNodes($scope.sectorType[0]);
            //if (temp.length > 0)
            //    $scope.srchCriteria.push(temp);


            SrvData.getMatchingClients($scope.clientSrchCriteria, $scope.techSrchCriteria, $scope.sectorSrchCriteria).then(function (response) {

                if (response.data != null && response.data != "null") {
                    debugger;
                    $scope.searchResults = response.data;
                    $scope.noResultsFound = false;
                }
                else {
                    if (response.data == null || response.data == "null") {
                        $scope.searchResults = [];
                        $scope.noResultsFound = true;
                    }
                    else {
                        alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                    }
                }
            }, function (err) {
                console.error("get referral form:", err);
            });


        };
    });

}());