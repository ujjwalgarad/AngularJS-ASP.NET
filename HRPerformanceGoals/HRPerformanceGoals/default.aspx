<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="HRPerformanceGoals._default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>

        .material-icons.md-dark { color: rgba(0, 0, 0, 0.70); }

        #idPersonImg{
            width:130px;
            height:150px;
            display:block;
            border-radius:8px;
        }

        #personName{
            font-family:Arial, Helvetica, sans-serif;
            margin-top:10px;
            width:130px;
            text-align:center
        }

        .container{
            padding-bottom:20px;
        }
    </style>

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

        <%--<div class="row">
            <div class="col-lg-4">
                <label>30-Day Goals for:</label>
                <strong>{{personFullName}}</strong>
            </div>
            <div class="col-lg-4">
                <label>Direct Manager:</label>
                <strong>{{managerFullName}}</strong>
            </div>
        </div>--%>
        <%--DEFAULT3.ASPX is the live page in use--%>
            <div layout="row" style="background-color:#F5F5F5;border-radius:8px;border:1px solid #A9A9A9">
                <div flex="15">
                    <div style="padding:10px">
                        <img class="imageContainer" id="idPersonImg" alt="Photo not available" ng-src="{{'http://chs-hand01/empPhotos/' + personTKID + '.jpg'}}">
                        <div id="personName">{{personFullName | uppercase}}</div>
                    </div>
                </div>
                <div flex="85">
                    <div style="padding:10px">
                    <table class="table table-condensed" style="background-color:#F5F5F5">
                        <tr>
                            <th width="20%">Direct Manager :</th>
                            <td width="20%">{{managerFullName | uppercase}}</td>
                            <th width="20%"></th>
                            <td width="20%"></td>
                        </tr>
                        <tr>
                            <th>TimeKeeper ID :</th>
                            <td>{{personTKID}}</td>
                            <th>Email ID :</th>
                            <td>{{personEmail}}</td>
                        </tr>
                        <tr>
                            <th>Position :</th>
                            <td>{{personJobTitle}}</td>
                            <th>Department :</th>
                            <td>{{personDept}}</td>
                        </tr>
                        <tr>
                            <th>Hiring Date :</th>
                            <td>{{personJoinedDate}}</td>
                            <th>Status :</th>
                            <td>{{Status}}</td>
                        </tr>
                    </table>
                        </div>
                </div>
            </div>
            
        <div ng-if="(isAdmin || isHR) && !releasedToManager">
           <%-- <div class="pull-right">
                <md-button type="button" class="md-raised md-primary" ng-click="addNewGoal()" ng-if="!releasedToManager" ng-disabled="showAddNewGoal">Add New Goal</md-button>   
            </div>--%>
            <%--<div style="clear:both"></div> --%>  <!--empty div to clear the float-->
            <ng-form name="goalForm">
            <div width="100%" style="padding-top:20px">  <%--ng-if="showAddNewGoal"--%>
                <md-input-container class="md-block">
                    <label>Add New Goal Desription</label>
                    <textarea id="goalText" ng-model="goal.goal" required md-no-asterisk md-maxlength="1000" rows="3" md-no-resize autofocus></textarea>
                </md-input-container>
                <div align="right">
                    <md-button type="button" class="md-raised md-primary" ng-click="addUpdateGoal()" ng-disabled="goalForm.$invalid">Save</md-button>
                    <md-button type="button" class="md-raised" ng-click="cancel()">Discard</md-button>
                </div>
            </div>
                </ng-form>
        </div>
        <!-----------------------------------------------------Show Added Goals--------------------------------------------------------------->
            <md-card ng-if="goals.length>0">
                <div layout="row">
                <md-card-title flex="{{showFeedbackTitle?50:100}}">
                      <md-card-title-text>
                        <span class="md-headline">Goals</span>
                      </md-card-title-text>
                </md-card-title>
                    <md-card-title ng-if="showFeedbackTitle" flex="50">
                      <md-card-title-text>
                        <span class="md-headline">Comments</span>
                      </md-card-title-text>
                </md-card-title>
                    </div>
                <md-card-content>
                    <div ng-repeat="goal in goals track by $index">
                        <!----------------------------------------------------------------------Goal Section-------------------------------------------------------------------->
                        <div layout="row">
                            <div flex="{{goal.Review || goal.reviewEdit ? 50 : 100}}" layout="row">
                                <md-card flex="95">  <%--style="height:150px;overflow-y:auto;overflow-x:hidden"--%>
                                    <md-card-content ng-if="!goal.editGoal">
                                        <label>Goal :</label>
                                        <div class="card-media"  style="white-space: pre-wrap">{{goal.Goal}}</div>
                                    </md-card-content>
                                    <md-card-content ng-if="goal.editGoal"  flex="90">
                                        <md-input-container class="md-block">
                                            <label>Edit This Goal</label>
                                            <textarea ng-model="goalInEdit.Goal" md-maxlength="1000" rows="3" md-no-resize></textarea>
                                        </md-input-container>
                                    </md-card-content>
                                </md-card>                          
                                <div layout="column"  flex="5" ng-if="!reviewCompleted">
                                    <md-button title="{{ currentEditGoal!=-1 ? 'Please save/cancel the current editing goal.' : ''}}" ng-disabled="currentEditGoal!=-1" class="md-icon-button" aria-label="Edit Goal" ng-if="!goal.editGoal && (isAdmin || isHR) && !releasedToManager" ng-click="editGoal(goal)"> 
                                        <i ng-style="currentEditGoal!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE254;</i>
                                    </md-button>
                                    <md-button title="{{ currentEditGoal!=-1 ? 'Please save/cancel the current editing goal.' : ''}}" ng-disabled="currentEditGoal!=-1" class="md-icon-button" aria-label="Remove Goal" ng-if="!goal.editGoal && (isAdmin || isHR) && !releasedToManager" ng-click="removeGoal(goal)">
                                        <i ng-style="currentEditGoal!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE872;</i>
                                    </md-button>
                                    <md-button class="md-icon-button" aria-label="Save Goal" ng-if="goal.editGoal && (isAdmin || isHR) && !releasedToManager"  ng-click="saveGoal(goalInEdit)">
                                        <i class="material-icons md-24 md-dark">&#xE161;</i>
                                    </md-button>
                                    <md-button class="md-icon-button" aria-label="Cancel Editing" ng-if="goal.editGoal && (isAdmin || isHR) && !releasedToManager" ng-click="cancelEditGoal(goal)">
                                        <i class="material-icons md-24 md-dark">&#xE5C9;</i>
                                    </md-button>
                                    <md-button  title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : 'Click to enter feedback'}}" ng-disabled="currentEditReview!=-1" class="md-icon-button" aria-label="Write Review" ng-if="!goal.Review && !goal.reviewEdit && (isAdmin || isManager) && releasedToManager" ng-click="writeReview(goal)">
                                        <i ng-style="currentEditReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE560;</i>
                                    </md-button>
                                </div>
                            </div>


                            <!----------------------------------------------------------------------Review Section-------------------------------------------------------------------->
                        <div layout="row" ng-if="goal.reviewEdit || goal.Review" flex="50">
                            <md-card flex="95">
                                <md-card-content style="background-color:#F5FAF8" ng-if="goal.Review && !goal.reviewEdit">
                                        <label>Comments/Feedback :</label>
                                        <div class="card-media"  style="white-space: pre-wrap">{{goal.Review}}</div>
                                </md-card-content>
                                <md-card-content ng-if="goal.reviewEdit">
                                    <md-input-container class="md-block">
                                        <label>Edit Comments/Feedback</label>
                                        <textarea ng-model="reviewInEdit.Review" md-no-asterisk md-maxlength="1000" rows="3" md-no-resize></textarea>
                                    </md-input-container>
                                </md-card-content>
                            </md-card>
                            <div layout="column" flex="5"  ng-if="!reviewCompleted">
                                <md-button  title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEditReview!=-1" class="md-icon-button" aria-label="Edit Review" ng-if="!goal.reviewEdit  && (isAdmin || isManager)" ng-click="editReview(goal)">
                                    <i ng-style="currentEditReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE254;</i>
                                </md-button>
                                <md-button  title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEditReview!=-1" class="md-icon-button" aria-label="Remove Review" ng-if="!goal.reviewEdit && (isAdmin || isManager)" ng-click="removeReview(goal)">
                                    <i ng-style="currentEditReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE872;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Save Review" ng-if="goal.reviewEdit && (isAdmin || isManager)"  ng-click="saveReview(reviewInEdit)">
                                    <i class="material-icons md-24 md-dark">&#xE161;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Cancel Editing" ng-if="goal.reviewEdit && (isAdmin || isManager)" ng-click="cancelEditReview(goal)">
                                    <i class="material-icons md-24 md-dark">&#xE5C9;</i>
                                </md-button>
                            </div>
                        </div> 
                            <!--Review End-->

                        </div>

                         
                    </div>
                </md-card-content>
                
            </md-card>
            <div ng-if="goals.length>0" class="pull-right">
                <button type="button" class="btn btn-success" title="{{ currentEditGoal!=-1 ? 'Please save/cancel the current editing goal.' : ''}}" ng-disabled="currentEditGoal!=-1" ng-click="changeStatus('release')" ng-if="(isHR || isAdmin) && !releasedToManager">RELEASE GOALS TO MANAGER</button>
                <button type="button" class="btn btn-success" title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEditReview!=-1" ng-click="changeStatus('submit')" ng-if="(isManager || isAdmin) && releasedToManager && !reviewCompleted">SUBMIT</button>
            </div>
        </div>
        </div>
    <input type="hidden" id="hPersonTKID" value="<%= Person.TKID %>" />
    <input type="hidden" id="hPersonFullName" value="<%= Person.FullName %>" />
    <input type="hidden" id="hPersonDept" value="<%= Person.Department %>" />
    <input type="hidden" id="hPersonJobTitle" value="<%= Person.JobTitle %>" />
    <input type="hidden" id="hPersonEmail" value="<%= Person.Email %>" />
    <input type="hidden" id="hPersonJoinedDate" value="<%= Person.JoinedDate %>" />
    <input type="hidden" id="hManagerTKID" value="<%= Manager.TKID %>" />
    <input type="hidden" id="hManagerFullName" value="<%= Manager.FullName %>" />
    <input type="hidden" id="hPermissionId" value="<%= PermissionId %>" />
    
</asp:Content>
