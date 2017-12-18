(function () {
    'use strict';
    
    //var app = angular.module("appCMClass", [angularDragula(angular)]);

    var app = angular.module("appCMClass", ["dndLists", "ivh.treeview", "ngMaterial", "ui.bootstrap"]); 

    app.config(function (ivhTreeviewOptionsProvider) {
        ivhTreeviewOptionsProvider.set({
            defaultSelectedState: false,
            validate: true,
            expandToDepth: -1,
            twistieExpandedTpl: '<i class="fa fa-folder-open-o" aria-hidden="true"></i>',
            twistieCollapsedTpl: '<i class="fa fa-folder-o" aria-hidden="true"></i>',
            twistieLeafTpl: '<i class="fa fa-tag" aria-hidden="true"></i>'
        });
    });

    app.directive('asciiBox', function (ivhTreeviewMgr) {
        return {
            restrict: 'AE',
            require: '^ivhTreeview',
            template: [
              '<span class="ascii-box">[',
                '<span ng-show="node.selected" class="x">x</span>',
                '<span ng-show="node.__ivhTreeviewIndeterminate" class="y">~</span>',
                '<span ng-hide="node.selected || node.__ivhTreeviewIndeterminate"> </span>',
              ']</span>',
            ].join(''),
            link: function (scope, element, attrs, ctrl) {
                element.on('click', function () {
                    ivhTreeviewMgr.select(ctrl.root(), scope.node, !scope.node.selected);
                    scope.$apply();
                });
            }
        };
    });

    //app.directive('ngEnter', function () {
    //    return function (scope, element, attrs) {
    //        element.bind("keydown keypress", function (event) {
    //            if (event.which === 13) {
    //                //scope.$apply(function () {
    //                //    scope.$eval(attrs.ngEnter, { 'event': event });
    //                //});

    //                event.preventDefault();
    //                return false;
    //            }
    //        });
    //    };
    //});

    //custom directive for ng-Enter
    app.directive('ngEnter', function () {
        return function (scope, element, attrs) {
            element.bind("keydown keypress", function (event) {
                if (event.which === 13) {
                    scope.$apply(function () {
                        scope.$eval(attrs.ngEnter);
                    });
                    event.preventDefault();
                }
            });
        };
    });

    app.directive('openTwist', function () {
        return {
            restrict: 'E',
            template: '<i class="fa fa-folder-open-o" aria-hidden="true"></i>'
        };
    });
}());