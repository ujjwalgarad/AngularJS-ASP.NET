(function () {
    'use strict';
    var app = angular.module("hrPerformanceGoals");

    app.controller("MainCtrl", function ($scope, SrvData, $rootScope, $filter, NgTableParams, $element, $window) {

        //getting information of person who is logged in
        //$scope.name = $('#hUserFullName').val();
        //$scope.userTKID = $('#hUserTKID').val();
        //$scope.userLogin = $('#hUserLogin').val();

        //$scope.hasPermission = ($("#hHasPermission").val() == "True");
        //$scope.isHR = ($("#hIsHR").val() == "True");
        //$scope.isManager = ($("#hIsManager").val() == "True");
        //$scope.PermissionId = parseInt($("#hPermissionId").val());
        $scope.isManager = true;
        $scope.PermissionId = 5;
        $scope.hasPermission = true;

        $scope.employees = [];
        $scope.goals = [];
        $scope.goal = {};

        //temporary obj: when an existing goal is being edited, we make a copy of it in this obj
        $scope.goalInEdit = {};

        //temporary obj: when an existing review is being edited, we make a copy of it in this obj
        $scope.reviewInEdit = {};

        //variable to track the ID of the 30-Day review which is being edited
        $scope.currentEditReview = -1;

        //variable to track the ID of the 60-Day review which is being edited
        $scope.currentEdit60DayReview = -1;

        //variable to track the ID of the goal which is being edited
        $scope.currentEditGoal = -1;

        //////////below variables track the status of the goal-reviews
        $scope.Status = "";
        $scope.StatusID = 3;
        $scope.Completed30DaysOn = "";
        $scope.Completed60DaysOn = "";
        ////////end
        $scope.goal = {};
        $scope.goals = [{
            Goal: "Understand the coding practices followed in the Solutions developement team",
            Review: "Ujjwal has acquired a good knowledge of coding practices",
            Review60Day : "Ujjwal has been implementing the set norms while building web applications which are assigned to him in sprint"
        }, {
            Goal: "Support and add features in Litigation Support app",
            Review: "Ujjwal has started resolving maintenance requests for Litigation App under Goerge's supervision",
            Review60Day: "Ujjwal can now support Litigation Support ap by himself and has built a good rapo with Litigation Team as well"
        }];
        $scope.goals.map(function (obj) {

            //adding 3 more varibales to obj. these variables work as a flag to indicate whether something is being edited or not
            obj.editGoal = false;
            obj.reviewEdit = false;
            obj.review60DayEdit = false;


        });


        //function getAllReviewsAndGoals(personTKID) {
        //    $scope.goal = {};
        //    SrvData.getAllReviewsAndGoals(personTKID).then(function (response) {
        //        debugger;
        //        if (response.data != "null") {

        //            $scope.goals = response.data;
        //            $scope.goals.map(function (obj) {

        //                //adding 3 more varibales to obj. these variables work as a flag to indicate whether something is being edited or not
        //                obj.editGoal = false;
        //                obj.reviewEdit = false;
        //                obj.review60DayEdit = false;


        //            });
        //        }
        //        if (response.data == "null") {
        //            $scope.goals = [];
        //        }

        //    }, function (err) {
        //        console.error("get referral form:", err);
        //    });

        //}

        //$scope.Date = function (date) {
        //    debugger;
        //    return new Date(date);
        //}

        function addUpdateGoal(goal, personTKID) {
            debugger;
            SrvData.addUpdateGoal(goal, personTKID).then(function (response) {
                debugger;
                if (response.data != "null") {
                    $window.location.reload();
                }
            }, function (err) {
                console.error("get referral form:", err);
            });
        }

        function getGoalsStatus(personTKID) {
            debugger;
            SrvData.getGoalsStatus(personTKID).then(function (response) {
                debugger;
                if (response.data != "null") {
                    $scope.Status = response.data.Status;
                    $scope.StatusID = response.data.StatusID;
                    $scope.Completed30DaysOn = response.data.Completed30DaysOn;
                    $scope.Completed60DaysOn = response.data.Completed60DaysOn;
                }

            }, function (err) {
                console.error("get referral form:", err);
            });
        }

        init();

        function init() {
            debugger;

            //getting the information of person(whose review is goal-review is being conducted) through query string
            //$scope.personTKID = $('#hPersonTKID').val();
            //$scope.personFullName = $('#hPersonFullName').val();
            //$scope.managerTKID = $('#hManagerTKID').val();
            //$scope.managerFullName = $('#hManagerFullName').val();
            //$scope.personDept = $('#hPersonDept').val();
            //$scope.personJobTitle = $('#hPersonJobTitle').val();
            //$scope.personEmail = $('#hPersonEmail').val();
            //$scope.personJoinedDate = $('#hPersonJoinedDate').val().split(" ")[0];

            $scope.personTKID = '4071';
            $scope.personFullName = 'Ujjwal Garad';
            $scope.managerTKID = '2222';
            $scope.managerFullName = 'Robert Shaw';
            $scope.personDept = 'IT';
            $scope.personJobTitle = 'Software Developer Co-op';
            $scope.personEmail = 'garad.u@husky.neu.edu';
            $scope.personJoinedDate = "11/20/2017";



            //if ($scope.PermissionId == 1) {                         //if user is HR or admin get reviews and goals status
            //   // getAllReviewsAndGoals($scope.personTKID);
            //   // getGoalsStatus($scope.personTKID);
            //}else{
            //    SrvData.checkIfManager($scope.personTKID, $scope.userTKID).then(function (response) { //else check if the user is manager of the person or not
            //        debugger;
            //        switch (response.data) {
            //            case "False":
            //                alert("You do not have permission to see this page.");
            //                $scope.hasPermission = false;
            //                break;

            //            case "True":
            //                getAllReviewsAndGoals($scope.personTKID);
            //                getGoalsStatus($scope.personTKID);
            //                break;

            //            default:
            //                alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
            //        }
            //    }, function (err) {
            //        console.error("get referral form:", err);
            //    });
            //}
            
        }


        $scope.changeStatus = function (status) {
            debugger;

            if (status == 'release') {                  //when HR is releasing the goal to manager
                if (confirm("You will not be able to make any changes to the added goals and un-added goals will be lost. Proceed?")) {
                    SrvData.changeStatus(status, $scope.personTKID).then(function (response) {
                        debugger;
                        if (response.data == "ok") {
                            //init();
                            $window.location.href = "allEmployees.aspx";
                        }
                        else {
                            alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                        }
                    }, function (err) {
                        console.error("get referral form:", err);
                    });
                }
            }
            //if (status == 'submit' || status == '60Day') {
            //    var emailObj = {};
            if (status == 'submit') {               //when Manager is submitting the 30-Day feedback
                var flag = false;
                    //checking if all goals have a associated review
                for (var g in $scope.goals) {
                    debugger;
                    if (!$scope.goals[g].Review || $scope.goals[g].Review.trim() == "") {
                            alert("Please provide feedback for all goals.");
                            flag = true;
                            break;
                        }
                    }
                    if (flag) return;

                    if (confirm("You will not be able to make any changes to the comments/feedback and unsaved changes will be lost. Proceed?")) {
                        SrvData.changeStatus(status, $scope.personTKID).then(function (response) {
                            debugger;
                            if (response.data == "ok") {
                                //init();
                                debugger;
                                var emailObj = {
                                
                                };

                                SrvData.sendEmail(emailObj).then(function (response) {
                                    if (response.data != "null" && response.data == "ok") {
                                        $window.location.href = "allEmployees.aspx";
                                    }
                                    else {
                                        alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                                    }
                                }, function (err) {
                                    console.log("send email failed" + err);
                                });
                            }
                            else {
                                alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                            }
                        }, function (err) {
                            console.error("get referral form:", err);
                        });
                    }
                }

            if (status == '60Day') {                    //when Manager is submitting the 60-Day feedback
                var flag = false;
                //checking if all goals have a associated review
                for (var g in $scope.goals) {
                    debugger;
                    if (!$scope.goals[g].Review60Day || $scope.goals[g].Review60Day.trim() == "") {
                        alert("Please provide feedback for all goals.");
                        flag = true;
                        break;
                    }
                }

                //for (var g of $scope.goals) {
                //    debugger;
                //    if (!g.Review60Day || g.Review60Day.trim() == "") {
                //        alert("Please provide feedback for all goals.");
                //        flag = true;
                //        break;
                //    }
                //}
                if (flag) return;

                    if (confirm("You will not be able to make any changes to the comments/feedback and unsaved changes will be lost. Proceed?")) {
                        SrvData.changeStatus(status, $scope.personTKID).then(function (response) {
                            debugger;
                            if (response.data == "ok") {
                                //init();
                                debugger;
                                var emailObj = {
                                    
                                };

                                SrvData.sendEmail(emailObj).then(function (response) {
                                    if (response.data != "null" && response.data == "ok") {
                                        $window.location.href = "allEmployees.aspx";
                                    }
                                    else {
                                        alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                                    }
                                }, function (err) {
                                    console.log("send email failed" + err);
                                });
                            }
                            else {
                                alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                            }
                        }, function (err) {
                            console.error("get referral form:", err);
                        });
                    }
                }
                //SrvData.sendEmail(emailObj).then(function (response) {
                //    if (response.data != "null" && response.data == "ok") {
                //        $window.location.href = "allEmployees.aspx";
                //    }
                //    else {
                //        alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                //    }
                //}, function (err) {
                //    console.log("send email failed" + err);
                //});
            //}
        }

        $scope.cancel = function () {
            debugger;
            $window.location.reload();

        }

        $scope.addUpdateGoal = function () {
            if (!$scope.goal.goal) {
                return;
            }
            addUpdateGoal($scope.goal, $scope.personTKID);
        }

        $scope.editGoal = function (goal) {
            //make copy of existing goal and put that copy in editor
            //if edited goal is cancelled then we can restore the original copy
            //if edited goal is saved then we can save the edited copy as new goal
            $scope.goalInEdit = angular.copy(goal);
            goal.editGoal = true;
            $scope.currentEditGoal = goal.GoalId;
        }

        $scope.editReview = function (goal) {
            $scope.reviewInEdit = angular.copy(goal);
            goal.reviewEdit = true;
            $scope.currentEditReview = goal.GoalId;
        }

        $scope.edit60DayReview = function (goal) {
            $scope.review60DayInEdit = angular.copy(goal);
            goal.review60DayEdit = true;
            $scope.currentEdit60DayReview = goal.GoalId;
        }

        $scope.saveGoal = function (goal) {
            debugger;
            addUpdateGoal(goal, $scope.personTKID);
            $scope.currentEditGoal = -1;
            //goal.editGoal = false;
        }

        $scope.saveReview = function (goal) {
            debugger;
            //goal.reviewEdit = false;
            addUpdateGoal(goal, $scope.personTKID);
            $scope.currentEditReview = -1;
        }

        $scope.save60DayReview = function (goal) {
            debugger;
            //goal.reviewEdit = false;
            addUpdateGoal(goal, $scope.personTKID);
            $scope.currentEdit60DayReview = -1;
        }

        $scope.cancelEditGoal = function (goal) {
            goal.editGoal = false;
            $scope.currentEditGoal = -1;
        }

        $scope.cancelEditReview = function (goal) {
            goal.reviewEdit = false;
            $scope.currentEditReview = -1;
        }

        $scope.cancelEdit60DayReview = function (goal) {
            goal.review60DayEdit = false;
            $scope.currentEdit60DayReview = -1;
        }

        $scope.removeGoal = function (goal) {
            debugger;
            if (confirm("Delete the selected goal from the goals list?")) {
                SrvData.removeGoal(goal.GoalId).then(function (response) {
                    debugger;
                    if (response.data != "ok") {
                        alert("Something went wrong. Please contact HelpDesk with below error message:\n\r" + response.data);
                    }
                    if (response.data == "ok") {
                        init();
                    }
                }, function (err) {
                    console.error("get referral form:", err);
                });
            }
        }

        $scope.removeReview = function (goal) {
            debugger;
            if (confirm("Remove this review from goal?")) {
                //goal.review = "";
                goal.Review = "";
                addUpdateGoal(goal, $scope.personTKID);

            }
        }

        $scope.remove60DayReview = function (goal) {
            debugger;
            if (confirm("Remove this review from goal?")) {
                //goal.review60Day = "";
                goal.Review60Day = "";
                addUpdateGoal(goal, $scope.personTKID);

            }
        }

        $scope.writeReview = function (goal) {
            $scope.reviewInEdit = angular.copy(goal);
            goal.reviewEdit = true;
            $scope.currentEditReview = goal.GoalId;
        }

        $scope.write60DayReview = function (goal) {
            debugger;
            $scope.review60DayInEdit = angular.copy(goal);
            goal.review60DayEdit = true;
            $scope.currentEdit60DayReview = goal.GoalId;
        }


    });  // Controller End:'MainCtrl'

}());