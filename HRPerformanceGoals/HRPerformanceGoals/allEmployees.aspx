<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="allEmployees.aspx.cs" Inherits="HRPerformanceGoals.allEmployees" %>
<%@ Register src="forms/inProgress.ascx" tagname="inProgress" tagprefix="uc1" %>
<%@ Register src="forms/completed.ascx" tagname="completed" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" ng-controller="AllEmpCtrl" ng-cloak ng-init="init()">
        <div ng-if="hasPermission">
            
            <%--{{ (empProgCompleted | filter:{StatusID:4}).length }}--%>
            <div layout="row" ng-if="isHR" style="margin-bottom:20px">
                 <input type="text" class="form-control" style="margin-top:6px" flex="30" ng-model="empToAdd" placeholder="Enter Employee Name"
                     uib-typeahead="e as e.PersonFullName for e in employees | filter:{PersonFullName:$viewValue} | limitTo:20"
                     autocomplete="off">
                <md-button type="button" flex="20" class="md-raised md-primary" ng-click="addEmployee(empToAdd)">Create Goals</md-button>
            </div>

        
    <div style="clear:both">  <%--ng-if="hasPermission"--%>
        <md-tabs md-selected="selectedIndex" md-dynamic-height>
                <md-tab id="tab0">
                    <md-tab-label>
                        In Progress <%--<span class="badge" ng-if="{{ (empProgCompleted | filter:{StatusID:4}).length }} >0 && isHR" style="margin-left:5px; margin-top:-4px;">{{(empProgCompleted|filter:{ReleasedToManager}).length}}</span>--%>
                    </md-tab-label>
                    <md-tab-body>
                        <md-card>
                            <md-card-content>
                                <uc1:inProgress ID="inProgress" runat="server" />
                            </md-card-content>
                        </md-card>
                    </md-tab-body>
                </md-tab>
            <md-tab id="tab1">  <%--md-on-select="getMatterRequests()"--%>
                    <md-tab-label>
                        Completed<%-- <span class="badge" ng-if="(empProgCompleted|filter:{ReviewCompleted}).length >0 && isHR"style="margin-left:5px; margin-top:-4px;">{{(empProgCompleted|filter:{ReviewCompleted}).length}}</span>--%>
                    </md-tab-label>
                    <md-tab-body>
                        <md-card>
                            <md-card-content>
                                <uc2:completed ID="completed" runat="server" />
                            </md-card-content>
                        </md-card>
                    </md-tab-body>
                </md-tab>
            </md-tabs>
        </div>
    <%--<div ng-if="!hasPermission">
            <span>You do not have authorization to view this page.</span>
            <span><a href="default.aspx">Back to Home page</a></span>
        </div>--%>
</div>
        <h3 ng-if="!hasPermission">You do not have authorization to view this page.</h3>
        </div>
    
</asp:Content>
