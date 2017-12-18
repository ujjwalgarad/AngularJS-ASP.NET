<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="HRPerformanceGoals.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
        <div ng-if="hasPermission">

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
                        <tr>
                            <th ng-if="StatusID==3 || StatusID==4">30-Day Check-in Date :</th>
                            <td ng-if="StatusID==3 || StatusID==4">{{Completed30DaysOn}}</td>
                            <th ng-if="StatusID==4">60-Day Check-in Date :</th>
                            <td ng-if="StatusID==4">{{Completed60DaysOn}}</td>
                        </tr>
                    </table>
                        </div>
                </div>
            </div>

        <div ng-if="isHR && StatusID==1"> <%--ng-if="isHR && !releasedToManager"--%>
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
                    <md-button type="button" class="md-raised" ng-click="cancel()">Reset</md-button>
                </div>
            </div>
                </ng-form>
        </div>
        <!-----------------------------------------------------Show Added Goals--------------------------------------------------------------->
            <div ng-if="goals.length>0">
            
                <%--<div layout="row">
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
                </div>--%>
                
                    <div ng-repeat="goal in goals track by $index">
                        <md-card ng-if="(isManager && StatusID>1) || isHR">
                            <md-card-content>
                        <!----------------------------------------------------------------------Goal Section-------------------------------------------------------------------->
                            <div layout="row"> <%--flex="{{goal.Review || goal.reviewEdit ? 50 : 100}}"--%>
                                <md-card style="background-color:#ECF5E0" flex="{{isHR && StatusID==1 ? 95:100}}">  <%--flex="{{isHR && !reviewCompleted ? 95:100}}--%>
                                    <md-card-content ng-if="!goal.editGoal">
                                        <%--<label>Goal Description :</label>--%>
                                        <div class="card-media" style="white-space: pre-wrap"><%--<i class="fa fa-flag-checkered fa-2x" aria-hidden="true"></i>&nbsp;&nbsp;--%><span style="font-size:18px;font-weight:600;color:#808080">{{goal.Goal}}</span></div>
                                    </md-card-content>
                                    <md-card-content ng-if="goal.editGoal">
                                        <md-input-container class="md-block">
                                            <label>Edit This Goal</label>
                                            <textarea ng-model="goalInEdit.Goal" md-maxlength="1000" rows="3" md-no-resize></textarea>
                                        </md-input-container>
                                    </md-card-content>
                                </md-card>                          
                                <div layout="column"  flex="5" ng-if="isHR && StatusID==1"> <%--ng-if="!reviewCompleted && isHR"--%>
                                    <md-button title="{{ currentEditGoal!=-1 ? 'Please save/cancel the current editing goal.' : ''}}" ng-disabled="currentEditGoal!=-1" class="md-icon-button" aria-label="Edit Goal"  ng-if="!goal.editGoal" ng-click="editGoal(goal)">  <%--ng-if="!goal.editGoal && !releasedToManager"--%>
                                        <i ng-style="currentEditGoal!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE254;</i>
                                    </md-button>
                                    <md-button title="{{ currentEditGoal!=-1 ? 'Please save/cancel the current editing goal.' : ''}}" ng-disabled="currentEditGoal!=-1" class="md-icon-button" aria-label="Remove Goal" ng-if="!goal.editGoal" ng-click="removeGoal(goal)">  <%--ng-if="!goal.editGoal && !releasedToManager"--%>
                                        <i ng-style="currentEditGoal!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE872;</i>
                                    </md-button>
                                    <md-button class="md-icon-button" aria-label="Save Goal" ng-if="goal.editGoal"  ng-click="saveGoal(goalInEdit)">  <%--ng-if="goal.editGoal && !releasedToManager"--%>
                                        <i class="material-icons md-24 md-dark">&#xE161;</i>
                                    </md-button>
                                    <md-button class="md-icon-button" aria-label="Cancel Editing" ng-if="goal.editGoal" ng-click="cancelEditGoal(goal)">  <%--ng-if="goal.editGoal && !releasedToManager"--%>
                                        <i class="material-icons md-24 md-dark">&#xE5C9;</i>
                                    </md-button>
                                </div>
                                <div ng-if="isManager && StatusID==2"><%--  ng-if="isManager && releasedToManager"--%>
                                    <md-button  title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : 'Click to enter feedback for 30-Day performance'}}" ng-disabled="currentEditReview!=-1" class="md-icon-button" aria-label="Write Review" ng-if="!goal.Review && !goal.reviewEdit" ng-click="writeReview(goal)">
                                        <i ng-style="currentEditReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE560;</i>
                                    </md-button>
                                </div>

                                <div layout="column" flex="5" ng-if="StatusID==3 && isManager && !goal.Review60Day">  <%--ng-if="!goal.Review60Day && isManager"--%>
                                <md-button title="{{ currentEdit60DayReview!=-1 ? 'Please save/cancel the current editing feedback.' : 'Click to enter feedback for 60-Day performance'}}" ng-disabled="currentEdit60DayReview!=-1" class="md-icon-button" aria-label="Write Review" ng-click="write60DayReview(goal)">
                                    <i ng-style="currentEdit60DayReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE560;</i>
                                </md-button>
                            </div>
                            </div>


                            <!----------------------------------------------------------------------30 Day Review Section-------------------------------------------------------------------->
                        <div layout="row" ng-if="goal.reviewEdit || goal.Review">  <%--flex="50"--%>
                            <md-card flex="{{isManager && StatusID==2 ? 95:100}}" class="alert alert-warning" ng-if="(isManager && StatusID>1) || (isHR && StatusID>2)"> <%--flex="{{isManager && !reviewCompleted ? 95:100}}"--%>
                                <md-card-content ng-if="goal.Review && !goal.reviewEdit"> <%--style="background-color:#ECF5E0"--%>
                                        <label>30-Day Feedback :</label>
                                        <div class="card-media"  style="white-space: pre-wrap">{{goal.Review}}</div>
                                </md-card-content>
                                <md-card-content ng-if="goal.reviewEdit">
                                    <md-input-container class="md-block">
                                        <label>Edit 30-Day Feedback</label>
                                        <textarea ng-model="reviewInEdit.Review" md-no-asterisk md-maxlength="1000" rows="3" md-no-resize></textarea>
                                    </md-input-container>
                                </md-card-content>
                            </md-card>
                            <div layout="column" flex="5"  ng-if="isManager && StatusID==2">
                                <md-button  title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEditReview!=-1" class="md-icon-button" aria-label="Edit Review" ng-if="!goal.reviewEdit" ng-click="editReview(goal)">
                                    <i ng-style="currentEditReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE254;</i>
                                </md-button>
                                <md-button  title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEditReview!=-1" class="md-icon-button" aria-label="Remove Review" ng-if="!goal.reviewEdit" ng-click="removeReview(goal)">
                                    <i ng-style="currentEditReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE872;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Save Review" ng-if="goal.reviewEdit"  ng-click="saveReview(reviewInEdit)">
                                    <i class="material-icons md-24 md-dark">&#xE161;</i>
                                </md-button>
                                <md-button class="md-icon-button" aria-label="Cancel Editing" ng-if="goal.reviewEdit" ng-click="cancelEditReview(goal)">
                                    <i class="material-icons md-24 md-dark">&#xE5C9;</i>
                                </md-button>
                            </div>
                            
                        </div> 

                        <!--------------------------------------------------------Show this row only when 60Day review is in progress------------------------------------------------>
                        <div layout="row" ng-if="goal.review60DayEdit || goal.Review60Day">
                            <%--<div flex="50">
                            </div>--%>
                            <!-----------------------------------------------------60 Day Review Section ---------------------------------------------------------------------------->
                            <%--<div layout="row" flex="50">--%>
                                <md-card flex="{{isManager && StatusID != 4 ? 95:100}}" class="alert alert-default" ng-if="(isManager && StatusID>2) || (isHR && StatusID>3)">
                                    <md-card-content ng-if="goal.Review60Day && !goal.review60DayEdit">
                                            <label>60-Day Feedback :</label>
                                            <div class="card-media"  style="white-space: pre-wrap">{{goal.Review60Day}}</div>
                                    </md-card-content>
                                    <md-card-content ng-if="goal.review60DayEdit">
                                        <md-input-container class="md-block">
                                            <label>Edit 60-Day Feedback</label>
                                            <textarea md-no-asterisk ng-model="review60DayInEdit.Review60Day" md-maxlength="1000" rows="3" md-no-resize></textarea>
                                        </md-input-container>
                                    </md-card-content>
                                </md-card>
                                <div layout="column" flex="5" ng-if="isManager && StatusID != 4">  <%--ng-if="goal.review60DayEdit"--%>
                                    <md-button  title="{{ currentEdit60DayReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEdit60DayReview!=-1" class="md-icon-button" aria-label="Edit Review" ng-if="!goal.review60DayEdit" ng-click="edit60DayReview(goal)">
                                        <i ng-style="currentEdit60DayReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE254;</i>
                                    </md-button>
                                    <md-button  title="{{ currentEdit60DayReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEdit60DayReview!=-1" class="md-icon-button" aria-label="Remove Review" ng-if="!goal.review60DayEdit" ng-click="remove60DayReview(goal)">
                                        <i ng-style="currentEdit60DayReview!=-1 && {'color': '#dedede'}" class="material-icons md-24 md-dark">&#xE872;</i>
                                    </md-button>
                                    <md-button class="md-icon-button" aria-label="Save Review" ng-if="goal.review60DayEdit"  ng-click="save60DayReview(review60DayInEdit)">
                                        <i class="material-icons md-24 md-dark">&#xE161;</i>
                                    </md-button>
                                    <md-button class="md-icon-button" aria-label="Cancel Editing" ng-if="goal.review60DayEdit" ng-click="cancelEdit60DayReview(goal)">
                                        <i class="material-icons md-24 md-dark">&#xE5C9;</i>
                                    </md-button>
                                </div>
                            <%--</div>--%>
                        </div>

                         </md-card-content>
                
            </md-card>
                    </div>
                
            </div>
            <div ng-if="goals.length>0" class="pull-right">
                <button type="button" class="btn btn-success" title="{{ currentEditGoal!=-1 ? 'Please save/cancel the current editing goal.' : ''}}" ng-disabled="currentEditGoal!=-1" ng-click="changeStatus('release')" ng-if="isHR && StatusID==1">RELEASE GOALS TO MANAGER</button>
                <button type="button" class="btn btn-success" title="{{ currentEditReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEditReview!=-1" ng-click="changeStatus('submit')" ng-if="isManager && StatusID==2">SUBMIT</button>
                <button type="button" class="btn btn-success" title="{{ currentEdit60DayReview!=-1 ? 'Please save/cancel the current editing feedback.' : ''}}" ng-disabled="currentEdit60DayReview!=-1" ng-click="changeStatus('60Day')" ng-if="isManager && StatusID == 3">SUBMIT</button>
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
