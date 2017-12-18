<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="completed.ascx.cs" Inherits="HRPerformanceGoals.forms.completed" %>
<div ng-controller="AllEmpCtrl"">
    
    
    
    <div ng-if="isHR">
        <table ng-table="tableParams" show-filter="true" class="table table-bordered table-striped">
                <tr ng-repeat="row in $data | filter : {StatusID: '4'}" class="fixed-width"> <%--filter : {ReviewCompleted: true}--%>
                    <td data-title="'Employee'" filter="{PersonFullName: 'text'}" sortable="'PersonFullName'"><a href="default3.aspx?personTKID={{row.PersonTKID}}&managerTKID={{row.ManagerTKID}}">{{row.PersonFullName}}</a></td>
                    <td data-title="'Department'" filter="{Department: 'text'}" sortable="'Department'">{{row.Department}}</td>
                    <td data-title="'Direct Manager'" filter="{ManagerFullName: 'text'}" sortable="'ManagerFullName'">{{row.ManagerFullName}}</td>
                    <td data-title="'Hire Date'" filter="{HireDate: 'text'}" sortable="'HireDate'">{{Date(row.HireDate) | date:'MMM d, y'}}</td>
                    <td data-title="'Status'" filter="{Status: 'text'}" sortable="'Status'">{{row.Status}}</td>
                </tr>
            </table>
    </div>

    <div ng-if="isManager">
    <table ng-table="tableParams" show-filter="true" class="table table-bordered table-striped">
                <tr ng-repeat="row in $data | filter : {StatusID:'4', ManagerTKID : loggedinUserTKID}" class="fixed-width"> <%--filter : {ReviewCompleted: true, ManagerTKID : loggedinUserTKID}--%>
                    <td data-title="'Employee'" filter="{PersonFullName: 'text'}" sortable="'PersonFullName'"><a href="default3.aspx?personTKID={{row.PersonTKID}}&managerTKID={{row.ManagerTKID}}">{{row.PersonFullName}}</a></td>
                    <td data-title="'Department'" filter="{Department: 'text'}" sortable="'Department'">{{row.Department}}</td>
                    <td data-title="'Direct Manager'" filter="{ManagerFullName: 'text'}" sortable="'ManagerFullName'">{{row.ManagerFullName}}</td>
                    <td data-title="'Hire Date'" filter="{HireDate: 'text'}" sortable="'HireDate'">{{Date(row.HireDate) | date:'MMM d, y'}}</td>
                    <td data-title="'Status'" filter="{Status: 'text'}" sortable="'Status'">{{row.Status}}</td>
                </tr>
            </table>
        </div>
</div>