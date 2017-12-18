/// <reference path="ng-dnd-ctrl.js" />

(function () {
    'use strict';

    var app = angular.module("appCMClass");




    app.controller("DndCtrl", function ($scope, SrvData, $timeout) {

        var jq = $.noConflict();

        //debugger;
        $scope.clientNumber = jq('#hClientNumber').val();
        $scope.matterNumber = jq('#hMatterNumber').val();
        $scope.originalMatters = [];
        $scope.showRemoveSrch = false;
        $scope.showAddClient = false;
        $scope.showNewClientLvl1 = false;


        //////////////Basic working model
        //$scope.models = {
        //    selected: null,
        //    lists: { "A": [], "B": [] }
        //};

        //// Generate initial model
        //for (var i = 1; i <= 3; ++i) {
        //    $scope.models.lists.A.push({ label: "Item A" + i });
        //    $scope.models.lists.B.push({ label: "Item B" + i });
        //}
        //////////////end

        $scope.dummy = function (event) {
            event.preventDefault();
            return false;
        };

        init();

        function init() {
            SrvData.getAllPoolsAndBadges().then(function (response) {

                if (response.data != null) {
                    //debugger;


                    $scope.technologyTypes = response.data[1].Badges; //badgesBox
                    $scope.sectorTypes = response.data[2].Badges;   //badgesBox2
                    $scope.clientType = response.data[0].Badges;

                    $scope.technologyTypes = appendParent($scope.technologyTypes);
                    $scope.sectorTypes = appendParent($scope.sectorTypes);
                    $scope.clientType = appendParent($scope.clientType);
                    debugger;

                    

                    $timeout(function(){buildTree()},1000);

                    //console.log(response.data[1]);
                    //console.log(response.data[2]);
                    //console.log(response.data[0]);
                }
                else {

                    alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                }
            }, function (err) {
                console.error("get referral form:", err);
            });


            getClientMatters();
        };


        function getClientMatters() {
            SrvData.getClientMatters($scope.clientNumber, $scope.matterNumber).then(function (response) {

                if (response.data != null) {
                    debugger;
                    $scope.client = {
                        profile: {
                            type: "client",
                            selected: null,
                            name: response.data.ClientName,
                            orgAttorney: response.data.OrgAttyName,
                            clientNumber: response.data.ClientNumber,
                            badges: {
                                clientType: {
                                    selected: null,
                                    type: "clientType",
                                    list: []
                                },
                                technology: {
                                    selected: null,
                                    type: "technology",
                                    list: []
                                },
                                sector: {
                                    selected: null,
                                    type: "sector",
                                    list: []
                                }
                            }
                        },
                        matters:[]
                    }

                    angular.forEach(response.data.Matters, function (matter) {
                        debugger;
                        var tempMatter = {
                            type:"matter",
                            selected: null,
                            matterNumber : matter.MatterNumber,
                            name : matter.MatterName,
                            practiceArea : matter.PracticeName,
                            badges: {
                                technology: {
                                    selected: null,
                                    type: "technology",
                                    list: []
                                },
                                sector: {
                                    selected: null,
                                    type: "sector",
                                    list: []
                                }
                            }
                        };
                        $scope.client.matters.push(tempMatter);
                    });
                    
                }
                else {

                    alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                }
            }, function (err) {
                console.error("get referral form:", err);
            });
        }


        $scope.addClient2Pool = function () {
            $scope.showAddClient = !$scope.showAddClient;
        }

        $scope.saveNewClient2Pool = function (newClientType) {
            debugger;
            var newType = {
                CategoryId: 1,
                CategoryName: "Client Type",
                ItemId: 99,
                Level: 0,
                ParentItemId: 0,
                list: [],
                name: newClientType,
                selected: null,
                subtype: null,
                type: "clientType"
            };

            $scope.clientType.push(newType);
            $scope.showAddClient = false;

        };

        $scope.editingId = 0;
        $scope.addClientType = function (itemId) {
            // $scope.showNewClientLvl1_ + itemId = !$scope.showNewClientLvl1_ + itemId;
            $scope.editingId = itemId;
            document.getElementById(itemId).click();
        };

        $scope.searchMatters = function (clientNumber, matterSrchKey) {
            debugger;
            SrvData.searchMatters(clientNumber, matterSrchKey).then(function (response) {

                if (response.data != null) {
                    debugger;
                    if ($scope.originalMatters.length ==0){
                        $scope.originalMatters = $scope.client.matters;
                    }
                    $scope.client.matters = [];

                    angular.forEach(response.data, function (matter) {
                        debugger;
                        var tempMatter = {
                            type: "matter",
                            selected: null,
                            matterNumber: matter.MatterNumber,
                            name: matter.MatterName,
                            practiceArea: matter.PracticeName,
                            badges: {
                                technology: {
                                    selected: null,
                                    type: "technology",
                                    list: []
                                },
                                sector: {
                                    selected: null,
                                    type: "sector",
                                    list: []
                                }
                            }
                        };
                        $scope.client.matters.push(tempMatter);
                    });

                    $scope.showRemoveSrch = true;

                }
                else {

                    alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                }
            }, function (err) {
                console.error("Error:", err);
            });
        }

        $scope.removeSearch = function () {
            $scope.showRemoveSrch = false;
            $scope.searchMatter = "";
            $scope.client.matters = $scope.originalMatters;
            $scope.originalMatters = [];

        }

        // jQuery function
        function buildTree() {
                
                // default to open only first layer
                jq('.tree li ul li').hide();
                //jq('.tree li ul li ul li').hide();

                jq('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
                jq('.tree li.parent_li > span').on('click', function (e) {
                    var children = jq(this).parent('li.parent_li').find(' > ul > li');
                    if (children.is(":visible")) {
                        children.hide('fast');
                        jq(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
                    } else {
                        children.show('fast');
                        if (children.context.lastElementChild.className == "icon-plus-sign") {
                            jq(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
                        }
                    }
                    e.stopPropagation();
                });
        }
        

        //$scope.client = {
        //    profile : {
        //        type:"client",
        //        selected: null,
        //        name: "Carnot, LLC",
        //        orgAttorney: "Callori, Frederick P.",
        //        clientNumber : "",
        //        //badges : []
        //        badges: {
        //            clientType: {
        //                selected: null,
        //                type: "clientType",
        //                list: [] /*[{
        //                    selected: null,
        //                    type: "clientType",
        //                    name: "Private",
        //                    parent: "Company"
        //                }]*/
        //            },
        //            technology: {
        //                selected: null,
        //                type: "technology",
        //                list: []
        //            },
        //            sector: {
        //                selected: null,
        //                type: "sector",
        //                list: []
        //            }
        //        }
        //    },
        //    matters: [
        //        {
        //            type:"matter",
        //            selected: null,
        //            matterNumber: "2012339-0000",
        //            name: "General",
        //            practiceArea : "Business and Technology (1140)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0001",
        //            name: "PTAP: Ketone Body-TCA Cycle Acid PRO1",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            name: "PTAP: Chiral Peptides PRO",
        //            matterNumber: "2012339-0002",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0003",
        //            name: "PTAP: N-Acylethanolamides PRO",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: { 
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0004",
        //            name: "PTAP: Carboxylic Acid-TCA Cycle Acid PRO",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0005",
        //            name: "PTAP: Ketone Body-TCA Cycle Acid PRO2",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0006",
        //            name: "PTAP: Ketone Body/Carboxylic Acid-TCA Cycle Acid PCT",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0007",
        //            name: "PTAP: Chiral Peptides PCT",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0008",
        //            name: "PTAP: Trimetazidine Duchenne's PRO",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        },
        //        {
        //            type: "matter",
        //            selected: null,
        //            matterNumber: "2012339-0009",
        //            name: "PTAP: N-Acylethanolamides PRO2",
        //            practiceArea: "Prosecution Matters (PIP)  (1410)",
        //            //badges: []
        //            badges: {
        //                technology: {
        //                    selected: null,
        //                    type: "technology",
        //                    list: []
        //                },
        //                sector: {
        //                    selected: null,
        //                    type: "sector",
        //                    list: []
        //                }
        //            }
        //        }
        //    ]
        //};





        //$scope.badgesBox = [
        //    {
        //        selected: null,
        //        type: "technology",
        //        name: "Badge 1-1"
        //    },
        //    {
        //        selected: null,
        //        type: "technology",
        //        name: "Badge 1-2"
        //    },
        //    {
        //        selected: null,
        //        type: "technology",
        //        name: "Badge 1-3"
        //    }
        //];

        //$scope.badgesBox2 = [
        //    {
        //        selected: null,
        //        type: "sector",
        //        name: "Badge 2-1"
        //    },
        //    {
        //        selected: null,
        //        type: "sector",
        //        name: "Badge 2-2"
        //    },
        //    {
        //        selected: null,
        //        type: "sector",
        //        name: "Badge 2-3"
        //    }
        //];

        //$scope.clientType = [
        //    {
        //        selected: null,
        //        type: "clientType",
        //        name: "Company",

        //            subType: {
        //                selected: null,
        //                type: "clientType",
        //                name: "subType1",
        //                list: [
        //                    {
        //                        selected: null,
        //                        type: "clientType",
        //                        name: "Public",
                                

        //                        subType: {
        //                            selected: null,
        //                            type: "clientType",
        //                            name: "subType2",
                                     
        //                            list: [
        //                                {
        //                                selected: null,
        //                                type: "clientType",
        //                                name: "xxx",
        //                                },
        //                                {
        //                                    selected: null,
        //                                    type: "clientType",
        //                                    name: "yyy",
        //                                }
        //                            ]
        //                        }
        //                    },
        //                    {
        //                        selected: null,
        //                        type: "clientType",
        //                        name: "Private"
                                
        //                    },
        //                    {
        //                        selected: null,
        //                        type: "clientType",
        //                        name: "Foreign"
        //                    },
        //                    {
        //                        selected: null,
        //                        type: "clientType",
        //                        name: "Multi-National"
        //                    }
        //                ]
        //            }
        //    },
        //    {
        //        selected: null,
        //        type: "clientType",
        //        name: "Client Type 2"
        //    },
        //    {
        //        selected: null,
        //        type: "clientType",
        //        name: "Client Type 3"
        //    }
        //];

        //$scope.clientType = appendParent($scope.clientType);

        $scope.removeBadge = function (list, item) {
            debugger;
            list.splice(item,1);
        }

        function appendParent(tree) {
            //debugger;
            angular.forEach(tree, function (parent) {
                //debugger;
                var root = parent.name;
                if (parent.list) {
                    angular.forEach(parent.list, function (child) {
                        //debugger;
                        //here I'd like to get name of children

                        child.parent = root;
                        if (child.list) {
                            angular.forEach(child.list, function (grandChild) {
                                //here I'd like to get name of children
                                //debugger;

                                grandChild.parent = root + ' > ' + child.name;
                            });
                        }
                    });
                }
            });

            console.log(tree);
            //debugger;
            return tree;
        };
        
        
        $scope.onDrop = function (srcList, srcIndex, targetList, targetIndex) {
            debugger;

            if (targetList.type == 'client') {
                var flag = false;
                for (var i = 0; i < targetList.badges.length; i++) {
                    if (targetList.badges[i] == srcList[srcIndex]) {
                        if (!flag)
                            flag = true;
                    }
                }
                if (!flag) {
                    targetList.badges.splice(targetIndex, 0, srcList[srcIndex]);
                } else {
                    alert("You cannot place this badge here. (May be it already is added OR trying to put in wrong section?)");
                }
            }
            else {
                var flag = false;
            if (srcList[0].type != targetList.type) {
                flag = true;
            }
            else {
                for (var i = 0; i < targetList.list.length; i++) {
                    if (targetList.list[i] == srcList[srcIndex]) {
                        if (!flag)
                            flag = true;
                    }
                }
            }
            if (!flag) {
                targetList.list.splice(targetIndex, 0, srcList[srcIndex]);
            } else {
                alert("You cannot place this badge here. (May be it already is added OR trying to put in wrong section?)");
            }
        }
        }






    });

}());