<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="viewer.aspx.cs" Inherits="cmClassification.viewer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .ascii-box {
            cursor: pointer;
            font-family: monospace;
        }

        .x {
            color: red;
        }

        .y {
            color: green;
        }
    </style>
    <div class="container">
        <div ng-controller="ViewerCtrl">
            <div class="row">
                <div class="col-md-3 well">
                    <div style="margin-bottom:-10px;">
                        
                        <md-input-container>
                            <label>Search the tag</label>
                             <input type="text"  ng-model="srchTree">
                          </md-input-container>
                       </div>
                    
                    <div ivh-treeview="clientType"
                        ivh-treeview-label-attribute="'name'"
                        ivh-treeview-expand-to-depth="1"
                        ivh-treeview-filter="srchTree">
                        <script type="text/ng-template">
                            <span ivh-treeview-toggle>
                                <span ivh-treeview-twistie></span>
                            </span>
                            <ascii-box></ascii-box>
                            <span class="ivh-treeview-node-label" ivh-treeview-toggle>
                                {{trvw.label(node)}}
                            </span>
                            <div ivh-treeview-children></div>
                        </script>
                    </div>
                    <div ivh-treeview="technologyType"
                        ivh-treeview-label-attribute="'name'"
                        ivh-treeview-expand-to-depth="1"
                        ivh-treeview-filter="srchTree">
                        <script type="text/ng-template">
                            <span ivh-treeview-toggle>
                                <span ivh-treeview-twistie></span>
                            </span>
                            <ascii-box></ascii-box>
                            <span class="ivh-treeview-node-label" ivh-treeview-toggle>
                                {{trvw.label(node)}}
                            </span>
                            <div ivh-treeview-children></div>
                        </script>
                    </div>
                    <div ivh-treeview="sectorType"
                        ivh-treeview-label-attribute="'name'"
                        ivh-treeview-expand-to-depth="1"
                        ivh-treeview-filter="srchTree">
                        <script type="text/ng-template">
                            <span ivh-treeview-toggle>
                                <span ivh-treeview-twistie></span>
                            </span>
                            <ascii-box></ascii-box>
                            <span class="ivh-treeview-node-label" ivh-treeview-toggle>
                                {{trvw.label(node)}}
                            </span>
                            <div ivh-treeview-children></div>
                        </script>
                    </div>
                    <md-button type="button" class="md-raised md-primary" ng-click="onSubmit()">Submit</md-button>
                   
                </div>
            
                <%--<div class="col-md-9">
                <div class="well">
                    Search: <span ng-show="srchCriteria.length>0">{{srchCriteria}}</span>
                </div>
            </div>--%>
                <div class="col-md-8 col-md-offset-1 well" ng-if="searchResults.length > 0">
                        <table class="table table-striped">
                            <tr>
                                <th>Client Number</th>
                                <th>Client Name</th>
                                <th>Total Matters</th>
                                <th>Matching Matters</th>
                            </tr>
                            <tr ng-repeat="result in searchResults track by $index">
                                <td>{{result.ClientNumber}}</td>
                                <td>{{result.ClientName}}</td>
                                <td>{{result.MatterCount}}</td>
                                <td>{{result.MatchingMattersCount}}</td>
                            </tr>
                        </table>
                </div>

                <div class="col-md-9 well" ng-if="noResultsFound">
                    <h3>No matching results found.</h3>
                </div>
           </div> 
        </div>
    </div>
</asp:Content>
