<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="lab1.aspx.cs" Inherits="cmClassification.lab1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div ng-controller="DndCtrl">

<!--Basic working model-->
<!--<div>
      <div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">List A</h3></div>
        <div class="panel-body">
            <ul dnd-list="models.lists.A">  <%--dnd-drop="callback({targetList: list, targetIndex: index})"--%>
                <li ng-repeat="item in models.lists.A"
                    dnd-draggable="item"
                    <%--dnd-moved="list.splice($index, 1)"--%>
                    dnd-effect-allowed="null"
                    dnd-selected="models.selected = item"
                    ng-class="{'selected': models.selected === item}">  <%--dnd-callback="onDrop(list, $index, targetList, targetIndex)"--%>
                    {{item.label}}
                    <i class="fa fa-times pull-right" aria-hidden="true" ng-click="remove()"></i>
                </li>
            </ul>
        </div>
      </div>

    <div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">List B</h3></div>
        <div class="panel-body">
            <ul style="padding-left:0px">  <%--dnd-drop="callback({targetList: list, targetIndex: index})"--%>
                <li ng-repeat="item in models.lists.B"
                    dnd-draggable="item"
                    dnd-effect-allowed="copy"
                    ng-class="{'selected': models.selected === item}"
                    style="display:block; border-bottom: 1px solid #ddd; padding: 10px 15px;">  <%--dnd-callback="onDrop(list, $index, targetList, targetIndex)"--%>
                    {{item.label}}
                </li>
            </ul>
        </div>
    </div>
</div> -->
<!--End basic working model-->
      <div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">Client</h3></div>
        <div class="panel-body">
            <ul dnd-list="client.matters"
                dnd-allowed-types="['matter']"
                >
                <li dnd-draggable="badges"
                    dnd-effect-allowed="null"
                    >
                    <b>Client Profile</b>
                    <%--<ul dnd-list="client.profile.badges"
                        dnd-drop="callback({targetList: client.profile, targetIndex: index})"> 
                        <li ng-repeat="t in client.profile.badges track by $index"
                            dnd-draggable="t"
                            dnd-effect-allow="null"
                            dnd-selected="client.profile.selected = client.profile"
                            ng-class="{'selected': client.profile.selected === client.profile}"
                            >
                            {{t.name}}
                            <i class="fa fa-times pull-right" aria-hidden="true"></i>
                        </li>
                    </ul>--%>

                    <div class="row">
                    <!--Client Type badges-->
                    <ul dnd-list="client.profile.badges.clientType.list"
                        dnd-drop="callback({targetList: client.profile.badges.clientType, targetIndex: index})"
                        class="alert alert-success col-md-4"> 
                        <strong>Client Type Badges:</strong>

                        <li ng-repeat="t in client.profile.badges.clientType.list track by $index"
                            dnd-draggable="t"
                            dnd-effect-allow="null"
                            dnd-selected="client.profile.badges.clientType.selected = t"
                            ng-class="{'selected': client.profile.badges.clientType.selected === t}"
                            >
                            {{t.name}}
                            <i class="fa fa-times pull-right" aria-hidden="true"></i>
                        </li>
                    </ul>

                    <!--Technology badges-->
                    <ul dnd-list="client.profile.badges.technology.list"
                        dnd-drop="callback({targetList: client.profile.badges.technology, targetIndex: index})"
                        class="alert alert-info col-md-4"> 
                        <strong>Technology Badges:</strong>

                        <li ng-repeat="t in client.profile.badges.technology.list track by $index"
                            dnd-draggable="t"
                            dnd-effect-allow="null"
                            dnd-selected="client.profile.badges.technology.selected = t"
                            ng-class="{'selected': client.profile.badges.technology.selected === t}"
                            >
                            {{t.name}}
                            <i class="fa fa-times pull-right" aria-hidden="true"></i>
                        </li>
                    </ul>

                    <!--Sector badges-->
                    <ul dnd-list="client.profile.badges.sector.list"
                        dnd-drop="callback({targetList: client.profile.badges.sector, targetIndex: index})"
                        class="alert alert-danger col-md-4"> 
                        <strong>Sector Badges:</strong>

                        <li ng-repeat="t in client.profile.badges.sector.list track by $index"
                            dnd-draggable="t"
                            dnd-effect-allow="null"
                            dnd-selected="client.profile.badges.sector.selected = t"
                            ng-class="{'selected': client.profile.badges.sector.selected === t}"
                            >
                            {{t.name}}
                            <i class="fa fa-times pull-right" aria-hidden="true"></i>
                        </li>
                    </ul>
                        </div>
                </li>
                
                <li ng-repeat="matter in client.matters track by $index"
                    dnd-draggable="matter"
                    dnd-effect-allowed="null"
                    dnd-type="matter.type"
                    class="alert alert-warning"
                    >
                    <b>{{matter.name}}</b>
                    <div class="row">
                    <!--Technology badges-->
                    <ul dnd-list="matter.badges.technology.list"
                        dnd-drop="callback({targetList: matter.badges.technology, targetIndex: index})"
                        class="alert alert-info col-md-6"> 
                        <strong>Technology Badges:</strong>

                        <li ng-repeat="t in matter.badges.technology.list track by $index"
                            dnd-draggable="t"
                            dnd-effect-allow="null"
                            dnd-selected="matter.badges.technology.selected = t"
                            ng-class="{'selected': badges.technology.selected === t}"
                            >
                            {{t.name}}
                            <i class="fa fa-times pull-right" aria-hidden="true"></i>
                        </li>
                    </ul>

                    <!--Sctor badges-->
                    <ul dnd-list="matter.badges.sector.list"
                        dnd-drop="callback({targetList: matter.badges.sector, targetIndex: index})"
                        class="alert alert-danger col-md-6">
                        <strong>Sector Badges:</strong>
                        <li ng-repeat="t in matter.badges.sector.list track by $index"
                            dnd-draggable="t"
                            dnd-effect-allow="null"
                            dnd-selected="matter.badges.sector.selected = t"
                            ng-class="{'selected': badges.sector.selected === t}"
                            >
                            {{t.name}}
                            <i class="fa fa-times pull-right" aria-hidden="true"></i>
                        </li>
                    </ul>
                        </div>
                </li>
                
            </ul>
        </div>
      </div>

    <%--<div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">Technology</h3></div>
        <div class="panel-body alert-info">
            <ul style="padding-left:0px">
                <li ng-repeat="b in badgesBox.list"
                    dnd-draggable="b"
                    dnd-effect-allowed="copy"
                    dnd-callback="onDrop(badgesBox.list, $index, targetList, targetIndex)"
                    ng-class="{'selected': badgesBox.selected === b}"
                    style="display:block; border-bottom: 1px solid #ddd; padding: 10px 15px;">
                    {{b}}
                </li>
            </ul>
        </div>
    </div>--%>

<%--    <div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">Sector</h3></div>
        <div class="panel-body alert-danger">
            <ul style="padding-left:0px">
                <li ng-repeat="b in badgesBox2.list"
                    dnd-draggable="b"
                    dnd-effect-allowed="copy"
                    dnd-callback="onDrop(badgesBox2.list, $index, targetList, targetIndex)"
                    ng-class="{'selected': badgesBox2.selected === b}"
                    style="display:block; border-bottom: 1px solid #ddd; padding: 10px 15px;">
                    {{b}}
                </li>
            </ul>
        </div>
    </div>--%> 
        <div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">Client Types</h3></div>
        <div class="panel-body alert-success">
            <ul style="padding-left:0px">
                <li ng-repeat="b in clientType"
                    dnd-draggable="b"
                    dnd-effect-allowed="copy"
                    dnd-callback="onDrop(clientType, $index, targetList, targetIndex)"
                    <%--ng-class="{'selected': badgesBox2.selected === b}"--%>
                    style="display:block; border-bottom: 1px solid #ddd; padding: 10px 15px;">
                    {{b.name}}
                </li>
            </ul>
        </div>
    </div>

            <div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">Technology</h3></div>
        <div class="panel-body alert-info">
            <ul style="padding-left:0px">
                <li ng-repeat="b in badgesBox"
                    dnd-draggable="b"
                    dnd-effect-allowed="copy"
                    dnd-callback="onDrop(badgesBox, $index, targetList, targetIndex)"
                    <%--ng-class="{'selected': badgesBox.selected === b}"--%>
                    style="display:block; border-bottom: 1px solid #ddd; padding: 10px 15px;">
                    {{b.name}}
                </li>
            </ul>
        </div>
    </div>

    <div class="panel panel-info col-sm-6">
        <div class="panel-heading"><h3 class="panel-title">Sector</h3></div>
        <div class="panel-body alert-danger">
            <ul style="padding-left:0px">
                <li ng-repeat="b in badgesBox2"
                    dnd-draggable="b"
                    dnd-effect-allowed="copy"
                    dnd-callback="onDrop(badgesBox2, $index, targetList, targetIndex)"
                    <%--ng-class="{'selected': badgesBox2.selected === b}"--%>
                    style="display:block; border-bottom: 1px solid #ddd; padding: 10px 15px;">
                    {{b.name}}
                </li>
            </ul>
        </div>
    </div> 

    


    </div>
</asp:Content>
