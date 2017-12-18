<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="HRPerformanceGoals._default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" ng-controller="MainCtrl" ng-cloak>
        <%--{{PermissionId}}
        {{isManager}}--%>
        <div ng-if="hasPermission">
        <%--<h3>30-Day Goals for <strong>Garad, Ujjwal</strong></h3>
        <h4>Supervisor : Shaw, Rob</h4>--%>

        <%--<div layout="row">
            <input type="text" class="form-control" placeholder="Search an Employee" ng-model="empToAdd"
                uib-typeahead="e as e.PersonFullName for e in employees | filter:{PersonFullName:$viewValue} | limitTo:20"
                autocomplete="off" flex="30">
            <md-button type="button" class="md-raised md-primary" ng-click="select(attyToAdd)" flex="20">Select This Employee</md-button>
        </div>--%>


<%--DEFAULT3.ASPX is the live page in use--%>
        <div class="row">
            <div class="col-lg-4">
                <label>30-Day Goals for:</label>
                <strong>{{personFullName}}</strong>
            </div>
            <div class="col-lg-4">
                <label>Direct Manager:</label>
                <strong>{{managerFullName}}</strong>
            </div>
        </div>
        <div ng-if="isAdmin || isHR">
            <md-button type="button" class="md-raised md-primary" ng-click="addNewGoal()" ng-disabled="releasedToManager">Add New Goal</md-button>   
        </div>
        <div width="100%" ng-if="showAddNewGoal && (isAdmin || isHR)">
            <md-input-container class="md-block">
                <label>Add New Goal Desription</label>
                <textarea ng-model="goal.goal" required md-no-asterisk md-maxlength="1000" rows="3" md-no-resize></textarea>
            </md-input-container>
            <div align="right">
                <md-button type="button" class="md-raised md-primary" ng-click="addUpdateGoal()" ng-disabled="!goal.goal">Save</md-button>
                <button type="button" class="btn btn-default">Cancel</button>
            </div>
        </div>
        
        <!-----------------------------------------------------Show Added Goals--------------------------------------------------------------->
            <md-card ng-if="goals.length>0">
                <md-card-title>
                      <md-card-title-text>
                        <span class="md-headline">Below Goals Have Been Added</span>
                      </md-card-title-text>
                </md-card-title>
                <md-card-content>
                    <div ng-repeat="goal in goals track by $index">
                        <!----------------------------------------------------------------------Goal Section-------------------------------------------------------------------->
                        <div layout="row">
                            <md-card style="height:150px;overflow-y:auto;overflow-x:hidden" flex="95">
                                <md-card-content ng-if="!goal.editGoal">
                                    <label>Goal:</label>
                                    <div class="md-media-xl card-media"  style="white-space: pre-wrap">{{goal.Goal}}</div>
                                </md-card-content>
                                <md-card-content ng-if="goal.editGoal"  flex="90">
                                    <md-input-container class="md-block">
                                        <label>Edit This Goal</label>
                                        <textarea ng-model="goalInEdit.Goal" md-maxlength="1000" rows="3" md-no-resize></textarea>
                                    </md-input-container>
                                </md-card-content>
                            </md-card>                          
                            <div class="col-lg-1" layout="column"  flex="5">
                                <md-button class="md-icon-button" aria-label="Edit Goal" ng-if="!goal.editGoal && (isAdmin || isHR) && !releasedToManager" ng-click="editGoal(goal)">
                                    <i class="material-icons md-24">&#xE254;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Remove Goal" ng-if="!goal.editGoal && (isAdmin || isHR) && !releasedToManager" ng-click="removeGoal(goal)">
                                    <i class="material-icons md-24">&#xE872;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Save Goal" ng-if="goal.editGoal && (isAdmin || isHR) && !releasedToManager"  ng-click="saveGoal(goalInEdit)">
                                    <i class="material-icons md-24">&#xE161;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Cancel Editing" ng-if="goal.editGoal && (isAdmin || isHR) && !releasedToManager" ng-click="cancelEditGoal(goal)">
                                    <i class="material-icons md-24">&#xE5C9;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Write Review" ng-if="!goal.Review && !goal.reviewEdit && (isAdmin || isManager)" ng-click="writeReview(goal)">
                                    <i class="material-icons md-24">&#xE560;</i>
                                </md-button>
                            </div>
                        </div>

                        <!----------------------------------------------------------------------Review Section-------------------------------------------------------------------->
                        <div layout="row" ng-if="goal.reviewEdit || goal.Review">
                            <md-card flex="95">
                                <md-card-content ng-if="goal.Review && !goal.reviewEdit">
                                    <div class="md-media-xl card-media"  style="white-space: pre-wrap">
                                        <label>Review:</label>
                                        <div>{{goal.Review}}</div>
                                    </div>
                                </md-card-content>
                                <md-card-content ng-if="goal.reviewEdit">
                                    <md-input-container class="md-block">
                                        <label>Edit Review</label>
                                        <textarea ng-model="reviewInEdit.Review" md-no-asterisk md-maxlength="1000" rows="3" md-no-resize></textarea>
                                    </md-input-container>
                                </md-card-content>
                            </md-card>
                            <div class="col-lg-1" layout="column" flex="5"  ng-if="!reviewCompleted">
                                <md-button class="md-icon-button" aria-label="Edit Review" ng-if="!goal.reviewEdit  && (isAdmin || isManager)" ng-click="editReview(goal)">
                                    <i class="material-icons md-24">&#xE254;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Remove Review" ng-if="!goal.reviewEdit && (isAdmin || isManager)" ng-click="removeReview(goal)">
                                    <i class="material-icons md-24">&#xE872;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Save Review" ng-if="goal.reviewEdit && (isAdmin || isManager)"  ng-click="saveReview(reviewInEdit)">
                                    <i class="material-icons md-24">&#xE161;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Cancel Editing" ng-if="goal.reviewEdit && (isAdmin || isManager)" ng-click="cancelEditReview(goal)">
                                    <i class="material-icons md-24">&#xE5C9;</i>
                                </md-button>
                            </div>
                        </div>  
                    </div>
                </md-card-content>
                <md-button type="button" class="md-raised md-primary" ng-click="changeStatus('release')" ng-if="isHR && !releasedToManager">Release To Manager</md-button>
                <md-button type="button" class="md-raised md-primary" ng-click="changeStatus('submit')" ng-if="isManager && !reviewCompleted">Submit</md-button>
            </md-card>
        </div>
        </div>
    <input type="hidden" id="hPersonTKID" value="<%= Person.TKID %>" />
    <input type="hidden" id="hPersonFullName" value="<%= Person.FullName %>" />
    <input type="hidden" id="hManagerFullName" value="<%= Manager.FullName %>" />
    <input type="hidden" id="hPermissionId" value="<%= PermissionId %>" />
</asp:Content>
