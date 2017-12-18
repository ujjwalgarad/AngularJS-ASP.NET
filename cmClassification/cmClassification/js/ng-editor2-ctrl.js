/// <reference path="ng-dnd-ctrl.js" />

(function () {
    'use strict';
    var app = angular.module("appCMClass");

    ///******uncomment this code if you are using this JS file
    //app.filter('startFrom', function () {
    //    return function (data, start) {
    //        return data.slice(start);
    //    }
    //});
    //////***end

    app.controller("EditorCtrl2", function ($scope, SrvData, $timeout) {

        var jq = $.noConflict();

        //variable to restrict number of matters to show on each page
        $scope.defaultLimited = 3;

        //variable to limit no of tags for matter as well as client level
        $scope.defaultTagLimit = 3;

        //variable to store current page number in pagination
        $scope.currentPage = 1;

        //these values will be taken from query string
        $scope.clientNumber = jq('#hClientNumber').val();
        $scope.matterNumber = jq('#hMatterNumber').val();

        //variables to limit showing the badges on client profile
        $scope.clientTypeLimit = $scope.defaultTagLimit;
        $scope.technologyLimit = $scope.defaultTagLimit;
        $scope.sectorLimit = $scope.defaultTagLimit;

        //these variables are used for manual searching
        //$scope.originalMatters = [];
        //$scope.showRemoveSrch = false;
        //$scope.originalItem = {};

        //variable to store filtered matters
        $scope.filteredMatters = {};

        //temporary object to store the tag which is being edited
        $scope.itemInEdit = {};

        $scope.editingParentId = -1; //stores the id of the PARENT node under which new node is gettign added
        $scope.editingId = -1;

        $scope.dummy = function (event) {
            event.preventDefault();
            return false;
        };





        init();

        function init() {
            SrvData.getAllPoolsAndBadges().then(function (response) {
                if (response.data != null) {
                    //debugger;
                    $scope.technologyTypes = response.data[1].Badges;
                    $scope.sectorTypes = response.data[2].Badges;
                    $scope.clientType = response.data[0].Badges;

                    //call function to add some extra fields
                    //$scope.technologyTypes = appendParent($scope.technologyTypes);
                    //$scope.sectorTypes = appendParent($scope.sectorTypes);
                    //$scope.clientType = appendParent($scope.clientType);
                    debugger;

                    $timeout(function () { initBuildTree(); buildTree() }, 1000);
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
                debugger;
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
                        matters: []
                    };

                    angular.forEach(response.data.Badges, function (b) {
                        switch (b.CategoryId) {
                            case 1:
                                $scope.client.profile.badges.clientType.list.push(b);
                                break;
                            case 2:
                                $scope.client.profile.badges.technology.list.push(b);
                                break;
                            case 3:
                                $scope.client.profile.badges.sector.list.push(b);
                                break;
                        }
                    });


                    angular.forEach(response.data.Matters, function (matter) {
                        debugger;
                        var tempMatter = {
                            type: "matter",
                            selected: null,
                            techTagsLimit: $scope.defaultTagLimit,
                            sectorTagsLimit: $scope.defaultTagLimit,
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

                        angular.forEach(matter.Badges, function (badge) {
                            if (badge.CategoryId == 2) {
                                tempMatter.badges.technology.list.push(badge);
                            }
                            if (badge.CategoryId == 3) {
                                tempMatter.badges.sector.list.push(badge);
                            }
                        });

                        $scope.client.matters.push(tempMatter);
                    });
                    debugger;
                }
                else {

                    alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                }
            }, function (err) {
                console.error("get referral form:", err);
            });
        }

        $scope.srchSubmit = function () {
            // $scope.defaultLimited = filteredMatters.length;
        }


        ////showing more categories on client profile
        $scope.showMoreCategories = function (type) {
            debugger;
            switch (type) {
                case 'clientType':
                    //$scope.showMoreClientType = !$scope.showMoreClientType;
                    if ($scope.clientTypeLimit != 999) {
                        $scope.clientTypeLimit = 999;
                    }
                    else {
                        $scope.clientTypeLimit = 3
                    }
                    break;
                case 'technology':
                    //$scope.showMoreClientType = !$scope.showMoreClientType;
                    if ($scope.technologyLimit != 999) {
                        $scope.technologyLimit = 999;
                    }
                    else {
                        $scope.technologyLimit = $scope.defaultTagLimit;
                    }
                    break;
                case 'sector':
                    //$scope.showMoreClientType = !$scope.showMoreClientType;
                    if ($scope.sectorLimit != 999) {
                        $scope.sectorLimit = 999;
                    }
                    else {
                        $scope.sectorLimit = $scope.defaultTagLimit;
                    }
                    break;
            }

        };

        ////showing more categories on matter level
        $scope.showMoreMatterCategories = function (type, matter) {
            debugger;
            switch (type) {
                case 'technology':
                    //$scope.showMoreClientType = !$scope.showMoreClientType;
                    if (matter.techTagsLimit != 999) {
                        matter.techTagsLimit = 999;
                    }
                    else {
                        matter.techTagsLimit = $scope.defaultTagLimit;
                    }
                    break;
                case 'sector':
                    //$scope.showMoreClientType = !$scope.showMoreClientType;
                    if (matter.sectorTagsLimit != 999) {
                        matter.sectorTagsLimit = 999;
                    }
                    else {
                        matter.sectorTagsLimit = $scope.defaultTagLimit;
                    }
                    break;
            }

        };

        $scope.addItem2Pool = function (itemId) {
            debugger;

            if ($scope.editingParentId != -1 && $scope.editingParentId != itemId) {
                //dont allow if already editing another branch
                alert("You are currently editing a tree branch.  Please save or discard your change before you continue.");
            } else {
                //store id of current editing item
                $scope.editingParentId = itemId;
                document.getElementById(itemId).click();
                debugger;
                //if the tree branch is closed then open it as well
                /*if (document.getElementById(itemId).getAttribute('isOpen') == "0") {
                    document.getElementById(itemId).click();
                }*/
            }
        }


        $scope.saveNewItem2Pool = function (newName, type, typeList) {
            debugger;

            if (newName.trim() != "" && newName) {

                for (var i = 0; i < typeList.length; i++) {
                    if (typeList[i].name.trim().toLowerCase() == newName.trim().toLowerCase()) {
                        alert("There already exists an item with same name in this branch. Please enter different name.");
                        return false;
                    }
                }


                var newItemType = '';
                var category = '';
                var catId = null;

                switch (type) {
                    case 'client':
                        newItemType = 'clientType';
                        category = 'Client Type';
                        catId = 1;
                        break;
                    case 'tech':
                        newItemType = 'technology';
                        category = 'Technology';
                        catId = 2;
                        break;
                    case 'sector':
                        newItemType = 'sector';
                        category = 'Sector';
                        catId = 3;
                        break;
                }

                var newType = {
                    CategoryId: catId,
                    CategoryName: category,
                    Level: 0,
                    ParentItemId: 0,
                    list: [],
                    name: newName.trim(),
                    selected: null,
                    subtype: null,
                    type: newItemType
                };

                SrvData.addBadge2Lib(newType).then(function (response) {
                    debugger;
                    if (response.data != null) {
                        //debugger;
                        newType.ItemId = response.data;
                        typeList.push(newType);
                        $scope.editingParentId = -1;
                        buildTree();
                    }
                    else {
                        alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                    }
                }, function (err) {
                    console.error("get referral form:", err);
                });
            }
        };

        $scope.saveNewTypeLvl1 = function (newTypeLvl1, parent, type) {
            debugger;
            if (newTypeLvl1.trim() != "" && newTypeLvl1) {

                for (var i = 0; i < parent.list.length; i++) {
                    if (parent.list[i].name.trim().toLowerCase() == newTypeLvl1.trim().toLowerCase()) {
                        alert("There already exists an item with same name in this branch. Please enter different name.");
                        return false;
                    }
                }

                var newItemType = '';
                var category = '';
                var catId = null;

                switch (type) {
                    case 'client':
                        newItemType = 'clientType';
                        category = 'Client Type';
                        catId = 1;
                        break;
                    case 'tech':
                        newItemType = 'technology';
                        category = 'Technology';
                        catId = 2;
                        break;
                    case 'sector':
                        newItemType = 'sector';
                        category = 'Sector';
                        catId = 3;
                        break;
                }

                var newType = {
                    CategoryId: catId,
                    CategoryName: category,
                    Level: parent.Level + 1,
                    ParentItemId: parent.ItemId,
                    parent: parent.Level == 1 ? parent.parent + ' > ' + parent.name : parent.name,
                    list: [],
                    name: newTypeLvl1.trim(),
                    selected: null,
                    subtype: null,
                    type: newItemType
                };


                SrvData.addBadge2Lib(newType).then(function (response) {
                    debugger;
                    if (response.data != null) {
                        //debugger;
                        newType.ItemId = response.data;
                        parent.list.push(newType);
                        $scope.editingParentId = -1;
                        buildTree();
                    }
                    else {

                        alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                    }
                }, function (err) {
                    console.error("get referral form:", err);
                });
            }
        }


        $scope.addNewType = function (itemId) {

            //Rules:
            //there are two possibilities of click 1. tree branch name  2. the '+' sign on tree branch name
            //1. when you click on tree branch name -> buildtree() function will handle the collase and expand part
            //2. when you click on '+' sign ->
            //a. if tree branch is collapsed then expand the branch and show input box
            //b. if tree branch is expanded then do nothing


            //if already editing in some other tree branch  then alert
            if ($scope.editingParentId != -1 && $scope.editingParentId != itemId) {
                alert("You are currently editing a tree branch.  Please save or discard your change before you continue.");
            } else {
                //if ($scope.editingParentId == 0) {

                //store id of current editing item
                $scope.editingParentId = itemId;
                document.getElementById(itemId).click();

                debugger;

                //if the tree branch is closed then open it as well
                /*if (document.getElementById(itemId).getAttribute('isOpen') == "0") {
                    document.getElementById(itemId).click();
                }*/
            }
        };

        $scope.discard = function () {
            $scope.editingParentId = -1;
        }

        $scope.discardEdit = function () {
            //if (confirm("Are you sure you want to discard your changes?")) {
            $scope.itemInEdit = {};
            //}
        }

        //method for manual searching

        //$scope.searchMatters = function (clientNumber, matterSrchKey) {
        //    debugger;
        //    SrvData.searchMatters(clientNumber, matterSrchKey).then(function (response) {
        //        if (response.data != null) {
        //            debugger;
        //            if ($scope.originalMatters.length == 0) {
        //                $scope.originalMatters = $scope.client.matters;
        //            }
        //            $scope.client.matters = [];
        //            angular.forEach(response.data, function (matter) {
        //                debugger;
        //                var tempMatter = {
        //                    type: "matter",
        //                    selected: null,
        //                    matterNumber: matter.MatterNumber,
        //                    name: matter.MatterName,
        //                    practiceArea: matter.PracticeName,
        //                    badges: {
        //                        technology: {
        //                            selected: null,
        //                            type: "technology",
        //                            list: []
        //                        },
        //                        sector: {
        //                            selected: null,
        //                            type: "sector",
        //                            list: []
        //                        }
        //                    }
        //                };
        //                $scope.client.matters.push(tempMatter);
        //            });
        //            $scope.showRemoveSrch = true;
        //        }
        //        else {
        //            alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
        //        }
        //    }, function (err) {
        //        console.error("Error:", err);
        //    });
        //}
        //$scope.removeSearch = function () {
        //    $scope.showRemoveSrch = false;
        //    $scope.searchMatter = "";
        //    $scope.client.matters = $scope.originalMatters;
        //    $scope.originalMatters = [];
        //}



        $scope.enableEditNode = function (item) {
            debugger;
            //$scope.editingId = itemId;
            //$scope.originalItem = item;
            $scope.itemInEdit = angular.copy(item);

        }

        $scope.saveEditedNode = function (newName, item) {
            debugger;

            if (newName.trim() == "" || !newName) {
                alert("Type Name can not be blank or empty.");
                return;
            }
            item.name = newName.trim();

            SrvData.updateBadgeName(item.ItemId, item.name).then(function (response) {
                debugger;
                if (response.data == "ok") {
                    //debugger;
                    $scope.itemInEdit = {};
                }
                else {
                    alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                }
            }, function (err) {
                console.error("get referral form:", err);
            });
        }

        // jQuery function which handles opening and closing of tree
        function buildTree() {

            jq('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Expand this branch');
            /*jq('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('isOpen', '0');*/ // 0 -> it is collapsed, 1 -> it is expanded
            jq('.tree li.parent_li > span').on('click', function (e) {
                var children = jq(this).parent('li.parent_li').find(' > ul > li');

                debugger;
                //if it is already expanded then collapse on click
                if (children.is(":visible") && $scope.editingParentId == -1) {
                    children.hide('fast');
                    jq(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');

                    /*jq(this).attr('isOpen', '0');*/
                } else { // if it is already collapsed then expand on click
                    if (!children.is(":visible")) {
                        children.show('fast');

                        //if (children.context.lastElementChild.className == "icon-plus-sign") {
                        jq(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
                        /*jq(this).attr('isOpen', '1');*/
                        //}
                    }
                }
                e.stopImmediatePropagation();
            });
        }


        function initBuildTree() {
            // default to open only first layer
            jq('.tree li ul li').hide();
            //jq('.tree li ul li ul li').hide();
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

        $scope.removeBadge = function (list, item) {
            debugger;

            if (confirm("Are you sure to remove this tag? This action can not be undone.")) {
                SrvData.detachBadge(item.CMBadgeId).then(function (response) {
                    debugger;
                    if (response.data == "ok") {
                        list.splice(list.indexOf(item), 1);
                    }
                    else {
                        alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                    }
                }, function (err) {
                    console.error("get referral form:", err);
                });
            }
        }


        //we don't need this procedure anymore coz we are getting the full name of tag from database now
        //function appendParent(tree) {
        //    //debugger;
        //    angular.forEach(tree, function (parent) {
        //        //debugger;
        //        var root = parent.name;
        //        if (parent.list) {
        //            angular.forEach(parent.list, function (child) {
        //                //debugger;
        //                //here I'd like to get name of children
        //                child.parent = root;
        //                if (child.list) {
        //                    angular.forEach(child.list, function (grandChild) {
        //                        //here I'd like to get name of children
        //                        //debugger;
        //                        grandChild.parent = root + ' > ' + child.name;
        //                    });
        //                }
        //            });
        //        }
        //    });
        //    console.log(tree);
        //    //debugger;
        //    return tree;
        //};


        $scope.onDrop = function (srcList, srcIndex, targetList, targetIndex, typeOfTarget) {
            debugger;

            if (typeOfTarget == 'client') {
                var flag = false;       //to check if item already exists in list

                if (srcList[0].type != targetList.type) {
                    flag = true;
                }
                else {
                for (var i = 0; i < targetList.list.length; i++) {
                    if (targetList.list[i].ItemId == srcList[srcIndex].ItemId) {
                        if (!flag)
                            flag = true;        //'true' means it already exists
                    }
                }
            }
                if (!flag) {
                    debugger;
                    var miniBadge = {
                        ItemId: srcList[srcIndex].ItemId,
                        CMNumber: $scope.clientNumber,
                        IsMatter: false,
                        CreatedByTkid: jq('#hUserTKID').val()
                    };
                    SrvData.attachBadge(miniBadge).then(function (response) {
                        debugger;
                        if (response.data != null && response.data != "null" && response.data != -1) {
                            srcList[srcIndex].CMBadgeId = response.data;
                            targetList.list.splice(targetIndex, 0, srcList[srcIndex]);
                        }
                        else {
                            alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                        }
                    }, function (err) {
                        console.error("get referral form:", err);
                    });
                } else {
                    alert("You cannot place this badge here. (May be it already is added OR trying to put in wrong section?)");
                }
            }
            else {              //this is for matter level


                var flag = false;
                if (srcList[0].type != targetList.type) {
                    flag = true;
                }
                else {
                    for (var i = 0; i < targetList.list.length; i++) {
                        if (targetList.list[i].ItemId == srcList[srcIndex].ItemId) {
                            if (!flag)
                                flag = true;
                        }
                    }





                }
                if (!flag) {
                    var miniBadge = {
                        ItemId: srcList[srcIndex].ItemId,
                        CMNumber: typeOfTarget,             //for matters, 'typeOfTarget' is a matterNumber
                        IsMatter: true,
                        CreatedByTkid: jq('#hUserTKID').val()
                    };
                    SrvData.attachBadge(miniBadge).then(function (response) {
                        debugger;
                        if (response.data != null && response.data != "null" && response.data != -1) {
                            srcList[srcIndex].CMBadgeId = response.data;
                            targetList.list.splice(targetIndex, 0, srcList[srcIndex]);
                        }
                        else {
                            alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                        }
                    }, function (err) {
                        console.error("get referral form:", err);
                    });

                    checkInClientProfile(targetList.type, srcList[srcIndex]);

                } else {
                    alert("You cannot place this badge here. (May be it already is added OR trying to put in wrong section?)");
                }
            }
        }


        function checkInClientProfile(targetType, srcItem) {
            debugger;
            var isInClientProfile = false;


            switch (targetType) {
                case "technology":
                    debugger;
                    $scope.client.profile.badges.technology.list.map(function (t) {
                        debugger;
                        //if (t.Level == srcItem.Level && t.name == srcItem.name) {
                        if (t.ItemId == srcItem.ItemId) {
                            isInClientProfile = true;
                        }
                    });

                    if (!isInClientProfile) {
                        var miniBadge = {
                            ItemId: srcItem.ItemId,
                            CMNumber: $scope.clientNumber,
                            IsMatter: false,
                            CreatedByTkid: jq('#hUserTKID').val()
                        };
                        debugger;
                        SrvData.attachBadge(miniBadge).then(function (response) {
                            debugger;
                            if (response.data != null && response.data != "null" && response.data != -1) {
                                srcItem.CMBadgeId = response.data;
                                $scope.client.profile.badges.technology.list.push(srcItem);
                            }
                            else {
                                alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                            }
                        }, function (err) {
                            console.error("get referral form:", err);
                        });
                    }
                    break;

                case "sector":
                    debugger;
                    $scope.client.profile.badges.sector.list.map(function (t) {
                        debugger;
                        //if (t.Level == srcItem.Level && t.name == srcItem.name) {
                        if (t.ItemId == srcItem.ItemId) {
                            isInClientProfile = true;
                        }
                    });

                    if (!isInClientProfile) {
                        var miniBadge = {
                            ItemId: srcItem.ItemId,
                            CMNumber: $scope.clientNumber,
                            IsMatter: false,
                            CreatedByTkid: jq('#hUserTKID').val()
                        };
                        debugger;
                        SrvData.attachBadge(miniBadge).then(function (response) {
                            debugger;
                            if (response.data != null && response.data != "null" && response.data != -1) {
                                srcItem.CMBadgeId = response.data;
                                $scope.client.profile.badges.sector.list.push(srcItem);
                            }
                            else {
                                alert("Something went wrong. Please contact HelpDesk with screenshot of below error message: \n\r" + response.data);
                            }
                        }, function (err) {
                            console.error("get referral form:", err);
                        });
                    }
                    break;
            }
        }

    });

}());

