<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="cmClassification.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="panel panel-info">
            <div class="panel-body alert-success tree">
                 <ul>
                    <li><span id="client"><i class="icon-exclamation-sign"></i><i class="fa fa-home" aria-hidden="true"></i></span><strong>&nbsp;Client Types</strong>&nbsp;
                        <i class="fa fa-plus" aria-hidden="true" ng-click="addClient2Pool('client')"></i>
                        <ul>
                            <li style="white-space:nowrap" ng-if="editingParentId == 'client'">
                                <input type="text" ng-model="newClientType" />&nbsp;<button type="button" ng-click="saveNewClient2Pool(newClientType)"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>&nbsp;
                                <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                            </li>
                            <li ng-repeat="b in clientType"
                                dnd-draggable="b"
                                dnd-effect-allowed="copy"
                                dnd-callback="onDrop(clientType, $index, targetList, targetIndex)"
                                style="display: block;">
                                    <span id="{{b.ItemId}}">
                                        <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                        <span ng-if="itemInEdit.ItemId != b.ItemId">{{b.name}}</span>
                                        <span ng-if="itemInEdit.ItemId==b.ItemId">
                                            <input type="text" ng-model="itemInEdit.name" />
                                            <button type="button" ng-click="saveEditedNode(itemInEdit.name, b)"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>&nbsp;
                                            <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                        </span>&nbsp;<span class="badge" style="background-color:#468847; color:white" ng-if="b.list.length > 0">{{b.list.length}}</span>&nbsp;
                                    </span>
                                     <i class="fa fa-plus" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="addClientType(b.ItemId)"></i>
                                     <i class="fa fa-pencil" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != b.ItemId" ng-click="enableEditNode(b)"></i>
                                    <ul>
                                        <li style="white-space:nowrap" ng-if="editingParentId==b.ItemId">
                                            <input type="text" ng-model="newClientLvl1" />&nbsp;<button type="button" ng-click="saveNewClientLvl1(newClientLvl1, b, $index)"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>&nbsp;
                                                <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                        </li>
                                        <li ng-repeat="st1 in b.list"
                                            dnd-draggable="st1"
                                            dnd-effect-allowed="copy"
                                            dnd-callback="onDrop(b.list, $index, targetList, targetIndex)"
                                            style="display: block;">
                                            <span id="{{st1.ItemId}}">
                                                <i class="fa fa-tags" aria-hidden="true"></i>&nbsp;
                                                <span ng-if="itemInEdit.ItemId != st1.ItemId">{{st1.name}}</span>
                                                <span ng-if="itemInEdit.ItemId==st1.ItemId">
                                                    <input type="text" ng-model="itemInEdit.name" />
                                                    <button type="button" ng-click="saveEditedNode(itemInEdit.name, st1)"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>&nbsp;
                                                    <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                                </span>&nbsp;
                                                <span class="badge" style="background-color:#468847; color:white" ng-if="st1.list.length > 0">{{st1.list.length}}</span></span>&nbsp;
                                            <i class="fa fa-plus" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="addClientType(st1.ItemId)"></i>
                                            <i class="fa fa-pencil" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st1.ItemId" ng-click="enableEditNode(st1)"></i>
                                            <ul>
                                                <li style="white-space:nowrap" ng-if="editingParentId==st1.ItemId">
                                                    <input type="text" ng-model="newClientLvl1" />&nbsp;<button type="button" ng-click="saveNewClientLvl1(newClientLvl1, st1, $index)"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>&nbsp;
                                                    <i class="fa fa-remove" aria-hidden="true" ng-click="discard()"></i>
                                                </li>
                                                <li  ng-repeat="st2 in st1.list"
                                                    dnd-draggable="st2"
                                                    dnd-effect-allowed="copy"
                                                    dnd-callback="onDrop(st1.list, $index, targetList, targetIndex)"
                                                    style="display: block;">
                                                    <span id="{{st2.ItemId}}">
                                                    <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;
                                                    <span ng-if="itemInEdit.ItemId != st2.ItemId">{{st2.name}}</span>
                                                    <span style="white-space:nowrap" ng-if="itemInEdit.ItemId==st2.ItemId">
                                                        <input type="text" ng-model="itemInEdit.name" />
                                                        <button type="button" ng-click="saveEditedNode(itemInEdit.name, st2)"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>&nbsp;
                                                        <i class="fa fa-remove" aria-hidden="true" ng-click="discardEdit()"></i>
                                                    </span></span>&nbsp;
                                                    <i class="fa fa-plus" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st2.ItemId" ng-click="addClientType(st2.ItemId)"></i>
                                                    <i class="fa fa-pencil" aria-hidden="true" ng-if="editingId == -1 && itemInEdit.ItemId != st2.ItemId" ng-click="enableEditNode(st2)"></i>
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


</asp:Content>
