<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="editor.aspx.cs" Inherits="cmClassification.editor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .alert{
            margin-bottom:5px !important;
            padding-bottom : 5px !important
        }

        .hand {
            cursor:pointer;
        }

    </style>   
<div ng-controller="EditorCtrl" ng-cloak>
    <div class="container-fluid" >
        
    <div class="panel panel-info col-sm-8" style="padding-right:10px;">
     <%-- <div>--%>
        <div class="panel-heading">
            <h3 class="panel-title">Client : {{client.profile.name}} &nbsp;&nbsp;&nbsp; Client Number : {{client.profile.clientNumber}}</h3>
        </div>
        <div>Originating Attorney : <b>{{client.profile.orgAttorney}}</b></div>
        <div style="overflow-y:auto; height:820px">
            <ul dnd-list="client.matters"
                dnd-allowed-types="['matter']"
                >
                <li dnd-draggable="badges"
                    dnd-effect-allowed="null"
                    >
                    
                    <div class="row">
                        <!--Client Type badges-->
                        <div style="padding:0px 2px" class="col-md-4">
                            <ul dnd-list="client.profile.badges.clientType.list"
                                dnd-drop="callback({targetList: client.profile.badges.clientType, targetIndex: index, typeOfTarget:client.profile.type})"
                                class="alert alert-success"
                                style="max-height:150px;overflow-y:auto"> 
                                <strong>Client Type:</strong>
                                <span class="pull-right" ng-if="client.profile.badges.clientType.list.length > 3 && clientTypeLimit < 999">
                                    <a href="" ng-click="showMoreCategories('clientType')">+{{client.profile.badges.clientType.list.length - defaultTagLimit}} more</a>
                                </span>
                                <span class="pull-right" ng-if="client.profile.badges.clientType.list.length > 3 && clientTypeLimit == 999">
                                    <a href="" ng-click="showMoreCategories('clientType')">show less</a>
                                </span>
                                <li style="font-size:11px;" ng-repeat="t in client.profile.badges.clientType.list | limitTo : clientTypeLimit"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="client.profile.badges.clientType.selected = t"
                                    ng-class="{'selected': client.profile.badges.clientType.selected === t}"
                                    >
                                    <%--<span ng-if="t.parent">{{t.parent}} > </span>--%>{{t.BadgeDisplayName}}
                                    <i class="fa fa-times pull-right hand" ng-click="removeBadge(client.profile.badges.clientType.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>

                    <!--Technology badges-->
                        <div style="padding:0px 2px" class="col-md-4">
                            <ul dnd-list="client.profile.badges.technology.list"
                                dnd-drop="callback({targetList: client.profile.badges.technology, targetIndex: index, typeOfTarget:client.profile.type})"
                                class="alert alert-info"
                                style="max-height:150px;overflow-y:auto"> 
                                <strong>Technology:</strong>
                                
                                <span class="pull-right" ng-if="client.profile.badges.technology.list.length > 3 && technologyLimit < 999">
                                    <a href="" ng-click="showMoreCategories('technology')">+{{client.profile.badges.technology.list.length - defaultTagLimit}} more</a>
                                </span>
                                <span class="pull-right" ng-if="client.profile.badges.technology.list.length > 3 && technologyLimit == 999">
                                    <a href="" ng-click="showMoreCategories('technology')">show less</a>
                                </span>

                                <li style="font-size:11px;" ng-repeat="t in client.profile.badges.technology.list | limitTo : technologyLimit"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="client.profile.badges.technology.selected = t"
                                    ng-class="{'selected': client.profile.badges.technology.selected === t}"
                                    >
                                    <span style="cursor:pointer" ng-click="getMattersByItemIdInCategory(2, t.ItemId, t.BadgeDisplayName)">{{t.BadgeDisplayName}} <span ng-if="t.ItemChildCount>0" style="margin-left:2px;" class="badge badge-default">{{t.ItemChildCount}}</span></span>  <%--ng-click="getMattersByItemIdInCategory(2, t.ItemId, t.BadgeDisplayName)"--%>
                                    <i class="fa fa-times pull-right hand" ng-click="removeBadge(client.profile.badges.technology.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>

                    <!--Sector badges-->
                        <div style="padding:0px 2px" class="col-md-4">
                            <ul dnd-list="client.profile.badges.sector.list"
                                dnd-drop="callback({targetList: client.profile.badges.sector, targetIndex: index, typeOfTarget:client.profile.type})"
                                class="alert alert-danger"
                                style="max-height:150px;overflow-y:auto"> 
                                <strong>Sector:</strong>

                                <span class="pull-right" ng-if="client.profile.badges.sector.list.length > 3 && sectorLimit < 999">
                                    <a href="" ng-click="showMoreCategories('sector')">+{{client.profile.badges.sector.list.length - defaultTagLimit}} more</a>
                                </span>
                                <span class="pull-right" ng-if="client.profile.badges.sector.list.length > 3 && sectorLimit == 999">
                                    <a href="" ng-click="showMoreCategories('sector')">show less</a>
                                </span>

                                <li style="font-size:11px;" ng-repeat="t in client.profile.badges.sector.list | limitTo : sectorLimit"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="client.profile.badges.sector.selected = t"
                                    ng-class="{'selected': client.profile.badges.sector.selected === t}"
                                    >
                                    <span style="cursor:pointer" ng-click="getMattersByItemIdInCategory(3, t.ItemId, t.BadgeDisplayName)">{{t.BadgeDisplayName}} <span ng-if="t.ItemChildCount>0" style="margin-left:2px;" class="badge badge-default">{{t.ItemChildCount}}</span></span>  <%--ng-click="getMattersByItemIdInCategory(3, t.ItemId, t.BadgeDisplayName)"--%>
                                    <i class="fa fa-times pull-right hand" ng-click="removeBadge(client.profile.badges.sector.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                    

        <!--------------------------------------------------------------------------------Matter List------------------------------------------------------------------------------------------------------------>
                        <div><b>Matters</b><span class="pull-right"> Total Matter Count: <b>{{client.matters.length}}</b></span></div>
                    <div class="row" style="clear:both" ng-show="isSrchingMatter">  <%--ng-if="isSrchingMatter"--%>
                        <div class="col-md-12">
                            <input type="text"  class="form-control" placeholder="Search matters for this client (For IE: double-click here)" ng-model="searchMatter" ng-enter="dummy($event)" />
                            <div ng-if="searchMatter">Matching Matters : {{(client.matters | filter : searchMatter).length}}</div>
                        </div>
                        <%--<button type="button" class="btn col-md-2" ng-click="searchMatters(client.profile.clientNumber, searchMatter)"><i class="fa fa-search"></i></button>
                        <button type="button" class="btn btn-default col-md-1" ng-if="showRemoveSrch" ng-click="removeSearch()"><i class="fa fa-remove"></i></button>--%>
                    </div>
                    <div ng-hide="isSrchingMatter">
                        <span class="pull-left">Showing Matters with <strong>{{srchCategory}}</strong> as <strong>{{srchBadge}}</strong></span>
                        <a class="pull-right" href="" ng-click="clearFilter()">Clear Filter</a>
                    </div>
                    <div style="clear:both"></div> <!--this is a dummy div just to clear the floats of above div-->
                </li>
                <li ng-if="isSrchingMatter" ng-repeat="matter in filteredMatters = (client.matters | filter: searchMatter)| startFrom:(currentPage - 1) * defaultLimited | limitTo : defaultLimited"  <%--limitTo : defaultLimited--%>
                    dnd-draggable="matter"
                    dnd-effect-allowed="null"
                    dnd-type="matter.type"
                    class="alert alert-warning"
                    >
               
                        <b>{{matter.matterNumber}} : {{matter.name}}</b>
                        <%--<div>Practice Area : {{matter.practiceArea}}</div>--%>
                        <div class="row">
                        <!--Technology badges-->
                            <div style="padding:0px 2px" class="col-md-6">
                                <ul dnd-list="matter.badges.technology.list"
                                    dnd-drop="callback({targetList: matter.badges.technology, targetIndex: index, typeOfTarget: matter.matterNumber})" 
                                    class="alert alert-info"
                                    style="max-height:150px;overflow-y:auto"> <!--send matter number as a 'typeOfTarget'-->
                                    <strong>Technology Tags:</strong>
                                    <span class="pull-right" ng-if="matter.badges.technology.list.length > 3 && matter.techTagsLimit < 999">
                                        <a href="" ng-click="showMoreMatterCategories('technology', matter)">+{{matter.badges.technology.list.length - defaultTagLimit}} more</a>
                                    </span>
                                    <span class="pull-right" ng-if="matter.badges.technology.list.length > 3 && matter.techTagsLimit == 999">
                                        <a href="" ng-click="showMoreMatterCategories('technology', matter)">show less</a>
                                    </span>

                                    <li style="font-size:11px;" ng-repeat="t in matter.badges.technology.list | limitTo : matter.techTagsLimit"
                                        dnd-draggable="t"
                                        dnd-effect-allow="null"
                                        dnd-selected="matter.badges.technology.selected = t"
                                        ng-class="{'selected': badges.technology.selected === t}"
                                        >
                                        <%--<span ng-if="t.parent">{{t.parent}} > </span>--%>{{t.BadgeDisplayName}}
                                        <i class="fa fa-times pull-right hand" ng-click="removeBadge(matter.badges.technology.list, t)" aria-hidden="true"></i>
                            
                                    </li>
                                </ul>
                            </div>

                    <!--Sector badges-->
                        <div style="padding:0px 2px" class="col-md-6">
                            <ul dnd-list="matter.badges.sector.list"
                                dnd-drop="callback({targetList: matter.badges.sector, targetIndex: index, typeOfTarget: matter.matterNumber})"
                                class="alert alert-danger"
                                style="max-height:150px;overflow-y:auto">
                                <strong>Sector Tags:</strong>
                                <span class="pull-right" ng-if="matter.badges.sector.list.length > 3 && matter.sectorTagsLimit < 999">
                                        <a href="" ng-click="showMoreMatterCategories('sector', matter)">+{{matter.badges.sector.list.length - defaultTagLimit}} more</a>
                                    </span>
                                    <span class="pull-right" ng-if="matter.badges.sector.list.length > 3 && matter.sectorTagsLimit == 999">
                                        <a href="" ng-click="showMoreMatterCategories('sector', matter)">show less</a>
                                    </span>
                                <li style="font-size:11px;" ng-repeat="t in matter.badges.sector.list | limitTo : matter.sectorTagsLimit"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="matter.badges.sector.selected = t"
                                    ng-class="{'selected': badges.sector.selected === t}"
                                    >
                                    <%--<span ng-if="t.parent">{{t.parent}} > </span>--%>{{t.BadgeDisplayName}}
                                    <i class="fa fa-times pull-right hand" ng-click="removeBadge(matter.badges.sector.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <!-- same code but showing different matters list -->
                <li ng-if="!isSrchingMatter" ng-repeat="matter in childMattersHasBadge | startFrom:(currentPage - 1) * defaultLimited | limitTo : defaultLimited"  <%--limitTo : defaultLimited--%>
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
                                    dnd-drop="callback({targetList: matter.badges.technology, targetIndex: index, typeOfTarget: matter.matterNumber})" 
                                    class="alert alert-info"
                                    style="max-height:150px;overflow-y:auto"> <!--send matter number as a 'typeOfTarget'-->
                                    <strong>Technology Tags:</strong>
                                    <span class="pull-right" ng-if="matter.badges.technology.list.length > 3 && matter.techTagsLimit < 999">
                                        <a href="" ng-click="showMoreMatterCategories('technology', matter)">+{{matter.badges.technology.list.length - defaultTagLimit}} more</a>
                                    </span>
                                    <span class="pull-right" ng-if="matter.badges.technology.list.length > 3 && matter.techTagsLimit == 999">
                                        <a href="" ng-click="showMoreMatterCategories('technology', matter)">show less</a>
                                    </span>

                                    <li style="font-size:11px;" ng-repeat="t in matter.badges.technology.list | limitTo : matter.techTagsLimit"
                                        dnd-draggable="t"
                                        dnd-effect-allow="null"
                                        dnd-selected="matter.badges.technology.selected = t"
                                        ng-class="{'selected': badges.technology.selected === t}"
                                        >
                                        <%--<span ng-if="t.parent">{{t.parent}} > </span>--%>{{t.BadgeDisplayName}}
                                        <i class="fa fa-times pull-right hand" ng-click="removeBadge(matter.badges.technology.list, t)" aria-hidden="true"></i>
                            
                                    </li>
                                </ul>
                            </div>

                    <!--Sector badges-->
                        <div style="padding-left:6px" class="col-md-6">
                            <ul dnd-list="matter.badges.sector.list"
                                dnd-drop="callback({targetList: matter.badges.sector, targetIndex: index, typeOfTarget: matter.matterNumber})"
                                class="alert alert-danger"
                                style="max-height:150px;overflow-y:auto">
                                <strong>Sector Tags:</strong>
                                <span class="pull-right" ng-if="matter.badges.sector.list.length > 3 && matter.sectorTagsLimit < 999">
                                        <a href="" ng-click="showMoreMatterCategories('sector', matter)">+{{matter.badges.sector.list.length - defaultTagLimit}} more</a>
                                    </span>
                                    <span class="pull-right" ng-if="matter.badges.sector.list.length > 3 && matter.sectorTagsLimit == 999">
                                        <a href="" ng-click="showMoreMatterCategories('sector', matter)">show less</a>
                                    </span>
                                <li style="font-size:11px;" ng-repeat="t in matter.badges.sector.list | limitTo : matter.sectorTagsLimit"
                                    dnd-draggable="t"
                                    dnd-effect-allow="null"
                                    dnd-selected="matter.badges.sector.selected = t"
                                    ng-class="{'selected': badges.sector.selected === t}"
                                    >
                                    <%--<span ng-if="t.parent">{{t.parent}} > </span>--%>{{t.BadgeDisplayName}}
                                    <i class="fa fa-times pull-right hand" ng-click="removeBadge(matter.badges.sector.list, t)" aria-hidden="true"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>

            </ul>

            <!--Pagination bar for search result -->
            <ul ng-show="isSrchingMatter" uib-pagination total-items="filteredMatters.length" ng-model="currentPage" items-per-page="defaultLimited" max-size="15"></ul>
             <!--Pagination bar for showing childmatters by itemId -->
            <ul ng-hide="isSrchingMatter" uib-pagination total-items="childMattersHasBadge.length" ng-model="currentPage" items-per-page="defaultLimited" max-size="15"></ul>
            
        </div>
    </div>
    <!----------------------------------------------------------------------------Available Pool of Badges(right side)---------------------------------------------------------------------------------------------------------------->
    <div class="col-md-4" style="overflow-y:auto; height:850px">
        <div class="panel panel-info">
            <div class="panel-body alert-success tree">
                 <ul>
                    <li>
                        <span id="client">
                            <i class="icon-exclamation-sign"></i>
                            <i class="fa fa-home" aria-hidden="true"></i>
                            <strong>&nbsp;Client Types</strong>
                        </span>&nbsp;
                        <i class="fa fa-slack"  title="Add New Client Type" aria-hidden="true" ng-click="addItem2Pool('client')"></i>
                        <ul>
                            <li style="white-space:nowrap" ng-if="editingParentId == 'client'">
                                <input type="text" ng-model="newClientType" ng-enter="saveNewItem2Pool(newClientType, 'client', clientType)" />&nbsp;
                                <button type="button" ng-click="saveNewItem2Pool(newClientType, 'client', clientType)">
                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                </button>&nbsp;
                                <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                            </li>
                            <li ng-repeat="b in clientType"
                                dnd-draggable="b"
                                dnd-effect-allowed="copy"
                                dnd-callback="onDrop(clientType, $index, targetList, targetIndex, typeOfTarget)"
                                style="display: block;">
                                    <span id="{{b.ItemId}}">
                                        <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                        <span ng-if="itemInEdit.ItemId != b.ItemId">{{b.name}}</span>
                                        <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==b.ItemId">
                                            <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, b)" />
                                            <button type="button" ng-click="saveEditedNode(itemInEdit.name, b)">
                                                <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                            </button>&nbsp;
                                            <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                        </span>&nbsp;
                                        <span class="badge" style="background-color:#468847; color:white" ng-if="b.list.length > 0">{{b.list.length}}</span>&nbsp;
                                    </span>&nbsp;
                                    <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="enableEditNode(b)"></i>&nbsp;
                                    <i class="fa fa-slack" title="Add New Type" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="addNewType(b.ItemId)"></i>
                                     
                                    <ul>
                                        <li style="white-space:nowrap" ng-if="editingParentId==b.ItemId">
                                            <input type="text" ng-model="newClientLvl1" ng-enter="saveNewTypeLvl1(newClientLvl1, b, 'client')" />&nbsp;
                                            <button type="button" ng-click="saveNewTypeLvl1(newClientLvl1, b, 'client')">
                                                <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                            </button>&nbsp;
                                            <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                        </li>
                                        <li ng-repeat="st1 in b.list"
                                            dnd-draggable="st1"
                                            dnd-effect-allowed="copy"
                                            dnd-callback="onDrop(b.list, $index, targetList, targetIndex, typeOfTarget)"
                                            style="display: block;">
                                            <span id="{{st1.ItemId}}">
                                                <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                                <span ng-if="itemInEdit.ItemId != st1.ItemId">{{st1.name}}</span>
                                                <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==st1.ItemId">
                                                    <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, st1)" />
                                                    <button type="button" ng-click="saveEditedNode(itemInEdit.name, st1)">
                                                        <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                    </button>&nbsp;
                                                    <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                                </span>&nbsp;
                                                <span class="badge" style="background-color:#468847; color:white" ng-if="st1.list.length > 0">{{st1.list.length}}</span>
                                            </span>&nbsp;
                                            <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="enableEditNode(st1)"></i>&nbsp;
                                            <i class="fa fa-slack" title="Add New Type" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="addNewType(st1.ItemId)"></i>
                                            
                                            <ul>
                                                <li style="white-space:nowrap" ng-if="editingParentId==st1.ItemId">
                                                    <input type="text" ng-model="newClientLvl1" ng-enter="saveNewTypeLvl1(newClientLvl1, st1, 'client')" />&nbsp;
                                                    <button type="button" ng-click="saveNewTypeLvl1(newClientLvl1, st1, 'client')">
                                                        <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                    </button>&nbsp;
                                                    <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                                </li>
                                                <li  ng-repeat="st2 in st1.list"
                                                    dnd-draggable="st2"
                                                    dnd-effect-allowed="copy"
                                                    dnd-callback="onDrop(st1.list, $index, targetList, targetIndex, typeOfTarget)"
                                                    style="display: block;">
                                                    <span id="{{st2.ItemId}}">
                                                    <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;
                                                    <span ng-if="itemInEdit.ItemId != st2.ItemId">{{st2.name}}</span>
                                                    <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==st2.ItemId">
                                                        <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, st2)" />
                                                        <button type="button" ng-click="saveEditedNode(itemInEdit.name, st2)">
                                                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                        </button>&nbsp;
                                                        <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                                    </span></span>&nbsp;
                                                    <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st2.ItemId" ng-click="enableEditNode(st2)"></i>
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
                        <li>
                            <span id="tech">
                                <i class="icon-exclamation-sign"></i>
                                <i class="fa fa-home" aria-hidden="true"></i>
                                <strong>&nbsp;Technologies</strong>
                            </span>&nbsp;
                            <i class="fa fa-slack" title="Add New Technology" aria-hidden="true" ng-click="addItem2Pool('tech')"></i>
                        <ul>
                            <li style="white-space:nowrap" ng-if="editingParentId == 'tech'">
                                <input type="text" ng-model="newTechType" ng-enter="saveNewItem2Pool(newTechType, 'tech', technologyTypes)" />&nbsp;
                                <button type="button" ng-click="saveNewItem2Pool(newTechType, 'tech', technologyTypes)">
                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                </button>&nbsp;
                                <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                            </li>
                            <li ng-repeat="b in technologyTypes"
                                dnd-draggable="b"
                                dnd-effect-allowed="copy"
                                dnd-callback="onDrop(technologyTypes, $index, targetList, targetIndex,typeOfTarget)"
                                style="display: block;">
                                <span id="{{b.ItemId}}">
                                    <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                    <span ng-if="itemInEdit.ItemId != b.ItemId">{{b.name}}</span>
                                    <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==b.ItemId">
                                        <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, b)" />
                                        <button type="button" ng-click="saveEditedNode(itemInEdit.name, b)">
                                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                        </button>&nbsp;
                                        <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                    </span>&nbsp;
                                    <span class="badge" style="background-color:#3a87ad; color:white" ng-if="b.list.length > 0">{{b.list.length}}</span>&nbsp;
                                </span>&nbsp;
                                <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="enableEditNode(b)"></i>&nbsp;
                                <i class="fa fa-slack" title="Add New Type" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="addNewType(b.ItemId)"></i>
                                <ul>
                                    <li style="white-space:nowrap" ng-if="editingParentId==b.ItemId">
                                        <input type="text" ng-model="newTechLvl1" ng-enter="saveNewTypeLvl1(newTechLvl1, b, 'tech')" />&nbsp;
                                        <button type="button" ng-click="saveNewTypeLvl1(newTechLvl1, b, 'tech')">
                                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                        </button>&nbsp;
                                        <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                    </li>
                                    <li ng-repeat="st1 in b.list"
                                        dnd-draggable="st1"
                                        dnd-effect-allowed="copy"
                                        dnd-callback="onDrop(b.list, $index, targetList, targetIndex,typeOfTarget)"
                                        style="display: block;">
                                        <span id="{{st1.ItemId}}">
                                            <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                            <span ng-if="itemInEdit.ItemId != st1.ItemId">{{st1.name}}</span>
                                            <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==st1.ItemId">
                                                <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, st1)" />
                                                <button type="button" ng-click="saveEditedNode(itemInEdit.name, st1)">
                                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                </button>&nbsp;
                                                <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                            </span>&nbsp;
                                            <span class="badge" style="background-color:#3a87ad; color:white" ng-if="st1.list.length > 0">{{st1.list.length}}</span>
                                        </span>&nbsp;
                                        <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="enableEditNode(st1)"></i>&nbsp;
                                        <i class="fa fa-slack" title="Add New Type" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="addNewType(st1.ItemId)"></i>
                                        
                                        <ul>
                                            <li style="white-space:nowrap" ng-if="editingParentId==st1.ItemId">
                                                <input type="text" ng-model="newTechLvl1" ng-enter="saveNewTypeLvl1(newTechLvl1, st1, 'tech')" />&nbsp;
                                                <button type="button" ng-click="saveNewTypeLvl1(newTechLvl1, st1, 'tech')">
                                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                </button>&nbsp;
                                                <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                            </li>
                                            <li ng-repeat="st2 in st1.list"
                                                dnd-draggable="st2"
                                                dnd-effect-allowed="copy"
                                                dnd-callback="onDrop(st1.list, $index, targetList, targetIndex,typeOfTarget)"
                                                style="display: block;">
                                                <span id="{{st2.ItemId}}">
                                                <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;
                                                <span ng-if="itemInEdit.ItemId != st2.ItemId">{{st2.name}}</span>
                                                <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==st2.ItemId">
                                                    <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, st2)" />
                                                    <button type="button" ng-click="saveEditedNode(itemInEdit.name, st2)">
                                                        <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                    </button>&nbsp;
                                                    <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                                    </span>
                                                </span>&nbsp;
                                                <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st2.ItemId" ng-click="enableEditNode(st2)"></i>
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
                        <li><span id="sector">
                                <i class="icon-exclamation-sign"></i>
                                <i class="fa fa-home" aria-hidden="true"></i>
                                <strong>&nbsp;Sectors</strong>
                            </span>&nbsp;
                            <i class="fa fa-slack" title="Add New Sector" aria-hidden="true" ng-click="addItem2Pool('sector')"></i>
                        <ul>
                            <li style="white-space:nowrap" ng-if="editingParentId == 'sector'">
                                <input type="text" ng-model="newTechType" ng-enter="saveNewItem2Pool(newTechType, 'sector', sectorTypes)" />&nbsp;
                                <button type="button" ng-click="saveNewItem2Pool(newTechType, 'sector', sectorTypes)">
                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                </button>&nbsp;
                                <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                            </li>
                            <li ng-repeat="b in sectorTypes"
                                dnd-draggable="b"
                                dnd-effect-allowed="copy"
                                dnd-callback="onDrop(sectorTypes, $index, targetList, targetIndex,typeOfTarget)"
                                style="display:block;">
                                <span id="{{b.ItemId}}">
                                    <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                    <span ng-if="itemInEdit.ItemId != b.ItemId">{{b.name}}</span>
                                    <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==b.ItemId">
                                        <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, b)" />
                                        <button type="button" ng-click="saveEditedNode(itemInEdit.name, b)">
                                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                        </button>&nbsp;
                                        <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                    </span>&nbsp;
                                    <span class="badge" style="background-color:#b94a48; color:white" ng-if="b.list.length > 0">{{b.list.length}}</span>
                                </span>&nbsp;
                                <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="enableEditNode(b)"></i>&nbsp;
                                <i class="fa fa-slack" title="Add New Type" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="addNewType(b.ItemId)"></i>
                                
                                <ul>
                                    <li style="white-space:nowrap" ng-if="editingParentId==b.ItemId">
                                        <input type="text" ng-model="newSectorLvl1" ng-enter="saveNewTypeLvl1(newSectorLvl1, b, 'sector')" />&nbsp;
                                        <button type="button" ng-click="saveNewTypeLvl1(newSectorLvl1, b, 'sector')">
                                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                        </button>&nbsp;
                                        <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                    </li>
                                    <li ng-repeat="st1 in b.list"
                                        dnd-draggable="st1"
                                        dnd-effect-allowed="copy"
                                        dnd-callback="onDrop(b.list, $index, targetList, targetIndex,typeOfTarget)"
                                        style="display:block;">
                                        <span id="{{st1.ItemId}}">
                                            <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                            <span ng-if="itemInEdit.ItemId != st1.ItemId">{{st1.name}}</span>
                                            <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==st1.ItemId">
                                                <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, st1)" />
                                                <button type="button" ng-click="saveEditedNode(itemInEdit.name, st1)">
                                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                </button>&nbsp;
                                                <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                            </span>&nbsp;
                                            <span class="badge" style="background-color:#b94a48; color:white" ng-if="st1.list.length > 0">{{st1.list.length}}</span>
                                        </span>&nbsp;
                                        <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="enableEditNode(st1)"></i>&nbsp;
                                        <i class="fa fa-slack" title="Add New Type" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="addNewType(st1.ItemId)"></i>                                        
                                        <ul>
                                            <li style="white-space:nowrap" ng-if="editingParentId==st1.ItemId">
                                                <input type="text" ng-model="newSectorLvl1" ng-enter="saveNewTypeLvl1(newSectorLvl1, st1, 'sector')" />&nbsp;
                                                <button type="button" ng-click="saveNewTypeLvl1(newSectorLvl1, st1, 'sector')">
                                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                </button>&nbsp;
                                                <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                            </li>
                                            <li ng-repeat="st2 in st1.list"
                                                dnd-draggable="st2"
                                                dnd-effect-allowed="copy"
                                                dnd-callback="onDrop(st1.list, $index, targetList, targetIndex,typeOfTarget)"
                                                style="display:block;">
                                                <span id="{{st2.ItemId}}">
                                                <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;
                                                <span ng-if="itemInEdit.ItemId != st2.ItemId">{{st2.name}}</span>
                                                <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==st2.ItemId">
                                                    <input type="text" ng-model="itemInEdit.name" ng-enter="saveEditedNode(itemInEdit.name, st2)" />
                                                    <button type="button" ng-click="saveEditedNode(itemInEdit.name, st2)">
                                                        <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                                    </button>&nbsp;
                                                    <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                                    </span></span>&nbsp;
                                                    <i class="fa fa-pencil-square-o" title="Edit" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st2.ItemId" ng-click="enableEditNode(st2)"></i>
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
