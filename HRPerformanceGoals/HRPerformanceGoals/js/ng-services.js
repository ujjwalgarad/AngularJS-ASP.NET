(function () {
    'use strict';
    var app = angular.module("hrPerformanceGoals");

    app.service('SrvData', function ($http) {

        this.getAllReviewsAndGoals = function (personTKID) {
            debugger;
            return $http({
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/GetAllReviewsAndGoals',
                params: { personTKID: personTKID },
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.sendEmail = function (email) {
            debugger;
            var input = $.param({ email: JSON.stringify(email) });
            return $http(
            {
                method: 'POST',
                url: 'wsServices/wSrvTools.asmx/SendEmail',
                data: input,
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            });
        };

        this.getGoalsStatus = function (personTKID) {
            debugger;
            return $http({
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/GetGoalsStatus',
                params: { personTKID: personTKID },
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.checkIfManager = function (personTKID, userTKID) {
            debugger;
            return $http({
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/CheckIfManager',
                params: { personTKID: personTKID, userTKID: userTKID, },
                headers: { 'Content-Type': 'application/json' }
            });
        };
        
        this.changeStatus = function (status, personTKID) {
            debugger;
            return $http({
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/ChangeStatus',
                params: { status: status, personTKID: personTKID },
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.getPermission = function (userLogin) {
            return $http(
            {
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/GetPermission',
                params: { userLogin: userLogin },
                headers: { 'Content-Type': 'application/json' }
            });
        }; 
        this.removeGoal = function (goalId) {
            debugger;
            return $http({
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/RemoveGoal',
                params: { goalId: goalId },
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.getAllEmployees = function () {
            debugger;
            return $http(
            {
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/GetAllEmployees',
                headers: { 'Content-Type': 'application/json' }
            });
        };
        
        this.getInProgressAndCompleted = function () {
            debugger;
            return $http(
            {
                method: 'Get',
                url: 'wsServices/wSrvTools.asmx/GetInProgressAndCompleted',
                headers: { 'Content-Type': 'application/json' }
            });
        };

        this.addEmployee = function (personTKID, createdByTKID) {
            debugger;
            var input = $.param({ personTKID: personTKID, createdByTKID: createdByTKID});
            return $http({
                method: 'Post',
                url: 'wsServices/wSrvTools.asmx/AddEmployee',
                data: input,
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            });
        };

        this.addUpdateGoal = function (goal, personTKID) {
            debugger;
            var input = $.param({ goal: JSON.stringify(goal), personTKID: personTKID });
            return $http({
                method: 'Post',
                url: 'wsServices/wSrvTools.asmx/AddUpdateGoal',
                data: input,
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            });
        };

    });

}());