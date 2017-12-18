<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="lab2.aspx.cs" Inherits="cmClassification.lab2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div ng-controller="DndCtrl" ng-cloak>
    <div class="container" >
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
    <div class="panel panel-info col-sm-8" style="padding-right:10px; overflow-y:auto; height:840px">
     <%-- <div>--%>
        <div class="panel-heading">
            <h3 class="panel-title">Client : {{client.profile.name}} &nbsp;&nbsp;&nbsp; Client Number : {{client.profile.clientNumber}}</h3>
        </div>
        <div class="panel-body" >
            <ul dnd-list="client.matters"
                dnd-allowed-types="['matter']"
                >
                <li dnd-draggable="badges"
                    dnd-effect-allowed="null"
                    >
                    <%--<b>Client Profile</b>--%>
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
                    <div><b>Originating Attorney : </b>{{client.profile.orgAttorney}}</div><br />
                    <div class="row">
                        <!--Client Type badges-->
                        <div class="col-md-4">
                            <ul dnd-list="client.profile.badges.clientType.list"
                                dnd-drop="callback({targetList: client.profile.badges.clientType, targetIndex: index})"
                                class="alert alert-success"> 
                                <strong>Client Type Badges:</strong>

                                <li ng-repeat="t in client.profile.badges.clientType.list track by $index"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="client.profile.badges.clientType.selected = t"
                                    ng-class="{'selected': client.profile.badges.clientType.selected === t}"
                                    >
                                    <span ng-if="t.parent">{{t.parent}} > </span>{{t.name}}
                                    <i class="fa fa-times pull-right" ng-click="removeBadge(client.profile.badges.clientType.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>

                    <!--Technology badges-->
                        <div style="padding:0 6px" class="col-md-4">
                            <ul dnd-list="client.profile.badges.technology.list"
                                dnd-drop="callback({targetList: client.profile.badges.technology, targetIndex: index})"
                                class="alert alert-info"> 
                                <strong>Technology Badges:</strong>

                                <li ng-repeat="t in client.profile.badges.technology.list track by $index"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="client.profile.badges.technology.selected = t"
                                    ng-class="{'selected': client.profile.badges.technology.selected === t}"
                                    >
                                    <span ng-if="t.parent">{{t.parent}} > </span>{{t.name}}
                                    <i class="fa fa-times pull-right" ng-click="removeBadge(client.profile.badges.technology.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>

                    <!--Sector badges-->
                        <div class="col-md-4">
                            <ul dnd-list="client.profile.badges.sector.list"
                                dnd-drop="callback({targetList: client.profile.badges.sector, targetIndex: index})"
                                class="alert alert-danger"> 
                                <strong>Sector Badges:</strong>

                                <li ng-repeat="t in client.profile.badges.sector.list track by $index"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="client.profile.badges.sector.selected = t"
                                    ng-class="{'selected': client.profile.badges.sector.selected === t}"
                                    >
                                    <span ng-if="t.parent">{{t.parent}} > </span>{{t.name}}
                                    <i class="fa fa-times pull-right" ng-click="removeBadge(client.profile.badges.sector.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                        <div><b>Matters</b></div>
                    <div class="row">
                        <div class="col-md-12"><input type="text" class="form-control" placeholder="Search matters for this client" ng-model="searchMatter" ng-enter="dummy($event)" /></div>
                        <%--<button type="button" class="btn col-md-2" ng-click="searchMatters(client.profile.clientNumber, searchMatter)"><i class="fa fa-search"></i></button>
                        <button type="button" class="btn btn-default col-md-1" ng-if="showRemoveSrch" ng-click="removeSearch()"><i class="fa fa-remove"></i></button>--%>
                    </div>
                </li>
                <%-- ng-repeat="matter in client.matters | limitTo : 3" ng-repeat="matter in filteredMatters = ( client.matters | filter: searchMatter)| limitTo : 3"--%>
                <li ng-repeat="matter in filteredMatters = ( client.matters | filter: searchMatter)| limitTo : 3"
                    dnd-draggable="matter"
                    dnd-effect-allowed="null"
                    dnd-type="matter.type"
                    class="alert alert-warning"
                    >
                        <b>{{matter.matterNumber}} : {{matter.name}}</b>
                        <div>Practice Area : {{matter.practiceArea}}</div>
                        <div class="row">
                        <!--Technology badges-->
                            <div style="padding-right:6px" class="col-md-6">
                                <ul dnd-list="matter.badges.technology.list"
                                    dnd-drop="callback({targetList: matter.badges.technology, targetIndex: index})"
                                    class="alert alert-info"> 
                                    <strong>Technology Badges:</strong>

                                    <li ng-repeat="t in matter.badges.technology.list track by $index"
                                        dnd-draggable="t"
                                        dnd-effect-allow="null"
                                        dnd-selected="matter.badges.technology.selected = t"
                                        ng-class="{'selected': badges.technology.selected === t}"
                                        >
                                        <span ng-if="t.parent">{{t.parent}} > </span>{{t.name}}
                                        <i class="fa fa-times pull-right" ng-click="removeBadge(matter.badges.technology.list, t)" aria-hidden="true"></i>
                            
                                    </li>
                                </ul>
                            </div>

                    <!--Sctor badges-->
                        <div style="padding-left:6px" class="col-md-6">
                            <ul dnd-list="matter.badges.sector.list"
                                dnd-drop="callback({targetList: matter.badges.sector, targetIndex: index})"
                                class="alert alert-danger">
                                <strong>Sector Badges:</strong>
                                <li ng-repeat="t in matter.badges.sector.list track by $index"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="matter.badges.sector.selected = t"
                                    ng-class="{'selected': badges.sector.selected === t}"
                                    >
                                    <span ng-if="t.parent">{{t.parent}} > </span>{{t.name}}
                                    <i class="fa fa-times pull-right" ng-click="removeBadge(matter.badges.sector.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <a href="#" class="pull-right" onclick="alert('This will either show next Matters on same page or go to the next page to show more Matters.')">Show More >></a>
      <%--</div>--%>
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
    <!----------------------------------------------------------------------------Available Pool of Badges---------------------------------------------------------------------------------------------------------------->
    <div class="col-md-4" style="overflow-y:auto; height:840px">
        <div class="panel panel-info">
            <div class="panel-body alert-success tree">
                 <ul>
                    <li><span><i class="icon-exclamation-sign"></i><i class="fa fa-home" aria-hidden="true"></i></span><strong>&nbsp;Client Types</strong>&nbsp;
                        <ul>
                            <li ng-repeat="b in clientType"
                                dnd-draggable="b"
                                dnd-effect-allowed="copy"
                                dnd-callback="onDrop(clientType, $index, targetList, targetIndex)"
                                style="display: block;">
                                    <span id="{{b.ItemId}}">
                                        <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;{{b.name}}&nbsp;<span class="badge" style="background-color:#468847; color:white" ng-if="b.list.length > 0">{{b.list.length}}</span>&nbsp;
                                        
                                    </span>
                                    <ul>
                                        <li ng-repeat="st1 in b.list"
                                            dnd-draggable="st1"
                                            dnd-effect-allowed="copy"
                                            dnd-callback="onDrop(b.list, $index, targetList, targetIndex)"
                                            <%--ng-class="{'selected': badgesBox2.selected === b}"--%>
                                            style="display: block;">
                                            <span><i class="fa fa-tags" aria-hidden="true"></i>&nbsp;{{st1.name}}&nbsp;<span class="badge" style="background-color:#468847; color:white" ng-if="st1.list.length > 0">{{st1.list.length}}</span></span>
                                            <ul>
                                                <li  ng-repeat="st2 in st1.list"
                                                    dnd-draggable="st2"
                                                    dnd-effect-allowed="copy"
                                                    dnd-callback="onDrop(st1.list, $index, targetList, targetIndex)"
                                                    <%--ng-class="{'selected': badgesBox2.selected === b}"--%>
                                                    style="display: block;"><i class="fa fa-tag" aria-hidden="true"></i>&nbsp;{{st2.name}}
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                          </li>
                      </ul> 
                    </div>
                </div>

            <div class="panel panel-info">
                <div class="panel-body alert-info tree">
                    <ul>
                        <li><span><i class="icon-exclamation-sign"></i><i class="fa fa-home" aria-hidden="true"></i></span><strong>&nbsp;Technologies</strong>
                        <ul>
                            <li ng-repeat="b in technologyTypes"
                                dnd-draggable="b"
                                dnd-effect-allowed="copy"
                                dnd-callback="onDrop(technologyTypes, $index, targetList, targetIndex)"
                                style="display: block;">
                                <span>
                                    <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;{{b.name}}&nbsp;<span class="badge" style="background-color:#3a87ad; color:white" ng-if="b.list.length > 0">{{b.list.length}}</span>
                                </span>

                                <ul>
                                    <li ng-repeat="st1 in b.list"
                                        dnd-draggable="st1"
                                        dnd-effect-allowed="copy"
                                        dnd-callback="onDrop(b.list, $index, targetList, targetIndex)"
                                        style="display: block;">
                                        <span><i class="fa fa-tags" aria-hidden="true"></i>&nbsp;{{st1.name}}&nbsp;<span class="badge" style="background-color:#3a87ad; color:white" ng-if="st1.list.length > 0">{{st1.list.length}}</span></span>

                                        <ul>
                                            <li ng-repeat="st2 in st1.list"
                                                dnd-draggable="st2"
                                                dnd-effect-allowed="copy"
                                                dnd-callback="onDrop(st1.list, $index, targetList, targetIndex)"
                                                style="display: block;"><i class="fa fa-tag" aria-hidden="true"></i>&nbsp;{{st2.name}}
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="panel panel-info">                    
                <div class="panel-body alert-danger tree">
                    <ul>
                        <li><span><i class="icon-exclamation-sign"></i><i class="fa fa-home" aria-hidden="true"></i></span><strong>&nbsp;Sectors</strong>
                        <ul>
                            <li ng-repeat="b in sectorTypes"
                                dnd-draggable="b"
                                dnd-effect-allowed="copy"
                                dnd-callback="onDrop(sectorTypes, $index, targetList, targetIndex)"
                                style="display:block;">
                                <span>
                                    <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;{{b.name}}&nbsp;<span class="badge" style="background-color:#b94a48; color:white" ng-if="b.list.length > 0">{{b.list.length}}</span>
                                </span>

                                <ul>
                                    <li ng-repeat="st1 in b.list"
                                        dnd-draggable="st1"
                                        dnd-effect-allowed="copy"
                                        dnd-callback="onDrop(b.list, $index, targetList, targetIndex)"
                                        style="display:block;">
                                        <span><i class="fa fa-tags" aria-hidden="true"></i>&nbsp;{{st1.name}}&nbsp;<span class="badge" style="background-color:#b94a48; color:white" ng-if="st1.list.length > 0">{{st1.list.length}}</span></span>

                                        <ul>
                                            <li ng-repeat="st2 in st1.list"
                                                dnd-draggable="st2"
                                                dnd-effect-allowed="copy"
                                                dnd-callback="onDrop(st1.list, $index, targetList, targetIndex)"
                                                style="display:block;">
                                                <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;{{st2.name}}
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
    </div>


  </div>
</div>
    
    <input type="hidden" id="hClientNumber" value="<%= ClientNumber %>" />
    <input type="hidden" id="hMatterNumber" value="<%= MatterNumber %>" />
</asp:Content>
