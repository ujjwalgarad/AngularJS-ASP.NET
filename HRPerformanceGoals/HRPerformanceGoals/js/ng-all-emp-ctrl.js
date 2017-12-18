(function () {
    'use strict';
    var app = angular.module("hrPerformanceGoals");

    app.controller("AllEmpCtrl", function ($scope, SrvData, $rootScope, $filter, NgTableParams, $element, $window, $mdDialog) {
        //permissions are taken from BasePage.cs

        debugger;
        //$scope.hasPermission = ($("#hHasPermission").val() == "True");
        //$scope.isAdmin = ($("#hIsAdmin").val() == "True");
        //$scope.isHR = ($("#hIsHR").val() == "True");
        //$scope.isManager = ($("#hIsManager").val() == "True");
        //$scope.PermissionId = parseInt($("#hPermissionId").val());
        //$scope.loggedinUserTKID = $("#hUserTKID").val();

        $scope.hasPermission = true;
        $scope.isHR = true;
        $scope.PermissionId = 1;

        $scope.empProgCompleted = [{
            PersonFullName: 'Ujjwal Garad',
            Department: 'IT',
            ManagerFullName: 'Robert Shaw',
            HireDate: new Date(),
            Status : 'In Progress'
        }, {
            PersonFullName: 'George Huang',
            Department: 'IT',
            ManagerFullName: 'Robert Shaw',
            HireDate: new Date(),
            Status: 'In Progress'
        }];

                $scope.tableParams = new NgTableParams(
                    { count: $scope.empProgCompleted.length }, { dataset: $scope.empProgCompleted }
                    );
                $scope.tableParams.settings({ counts: [] });
      

        $scope.init =  function() {
            debugger; 
            var loggedinUser = $("#hUserLogin").val().toUpperCase();
           

            SrvData.getAllEmployees().then(function (response) {
                debugger;
                if (response.data != "null") {
                    debugger;
                    $scope.employees = response.data;
                }
            }, function (err) {
                console.log("Error while getting list:" + err);
            });

            //SrvData.getInProgressAndCompleted().then(function (response) {
            //    debugger;
            //    if (response.data != "null") {
            //        debugger;
            //        $scope.empProgCompleted = response.data;
            //        $scope.empProgCompleted.map(function (obj) {
            //            debugger;
            //            obj.HireDate = $scope.Date(obj.HireDate);
            //        });

            //        //$scope.tableParams = new NgTableParams(
            //        //    { count: 50 }, { dataset: $scope.empProgCompleted }
            //        //    );
            //        //$scope.tableParams.settings({ counts: [$scope.tableParams.total()] });

            //        $scope.tableParams = new NgTableParams(
            //            { count: $scope.empProgCompleted.length }, { dataset: $scope.empProgCompleted }
            //            );
            //        $scope.tableParams.settings({ counts: [] });
            //    }
            //}, function (err) {
            //    console.log("Error while getting list:" + err);
            //});

        }

        $scope.init();
        //Function to convert string to date.
        $scope.Date = function (date) {
            debugger;
            return new Date(date);
        }

        $scope.addEmployee = function (empToAdd) {
            debugger;
            SrvData.addEmployee(empToAdd.PersonTKID, $('#hUserTKID').val()).then(function (response) {
                debugger;
                if (response.data != "null") {
                    debugger;
                    $window.location.href = "default3.aspx?personTKID=" + response.data.PersonTKID + "&managerTKID=" + response.data.ManagerTKID;
                }
            }, function (err) {
                console.log("Error while getting list:" + err);
            });
        }


    });  // Controller End:'MainCtrl'

}());