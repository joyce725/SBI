//var ce_objs = {};
//var ce_TILE;
function country_economy(_node, _layerid, _on, _chk, _z, $cb, _year) {
    //var _type = _node.key.replace(/\layer_/g, '');
    var _type = _node.data.Info.replace(/\_/g, ' ');

    return {
        isChecked: false,
        category: _layerid,
        features: [],
        clearMap: function () {
            var i;
            for (i in this.features) {
                if (this.features.hasOwnProperty(i)) {

                    this.toggle(this.features[i], _layerid);
                }
            }
            this.features.length = 0;
            $cb.removeClass('loading');
        },
        mapIt: function (_layerid) {
            var url = location.protocol + "//" + document.location.host + "/CDRI-SIIS_WebAPI/api/STAT_Open_CountryEconomy?year=" + _year + "&type=" + _type;

            var self = this;
            jQuery.ajax({
                type: "GET",
                url: url,
                dataType: "json"
            }).done(function (data) {
                jQuery.each(data, function (i, item) {
                    var wkt = new Wkt.Wkt()
                    , obj;
                    wkt.read(item.tb2.geom.Geometry.WellKnownText);
                    var config = {
                        fillColor: '#F0F0F0',
                        strokeColor: '#5C5C5C',
                        fillOpacity: 0.7,
                        strokeOpacity: 1,
                        strokeWeight: 1,
                    }

                    var _data = item.tb1.economy_detail_statistic;
                    switch (true) {
                        case _data <= TILE[0]:
                            config.fillColor = "#41A85F";
                            break;
                        case _data > TILE[0] && _data <= TILE[1]:
                            config.fillColor = "#8db444";
                            break;
                        case _data > TILE[1] && _data <= TILE[2]:
                            config.fillColor = "#FAC51C";
                            break;
                        case _data > TILE[2] && _data <= TILE[3]:
                            config.fillColor = "#d87926";
                            break;
                        case _data > TILE[3]:
                            config.fillColor = "#B8312F";
                            break;
                    }
                    obj = wkt.toObject(config);

                    if (Wkt.isArray(obj)) {
                        for (i in obj) {
                            if (obj.hasOwnProperty(i) && !Wkt.isArray(obj[i])) {

                                self.toggle(obj[i], _layerid);
                            }
                        }

                        self.features = self.features.concat(obj);
                    } else {

                        self.toggle(obj, _layerid);
                        self.features.push(obj);
                    }

                    $cb.removeClass('loading');

                });
            });
        },
        toggle: function (layer, _layerid) {
            gmelayer_active = layer;
            var self = this;
            function layerOpen() {
                layer.setMap(map); gmelayers_stack[_layerid] = layer;

                self.node_chk(true);
            }
            function layerClose() {
                layer.setMap(null); delete gmelayers_stack[_layerid];

                self.node_chk(false);
            }

            var stat = layer.getMap() ? true : false;

            if (stat) { layerClose(); } else { layerOpen(); }

        },
        node_chk: function (bool) {

            _node.unselectable = false;

            if (_chk == false) { return false; }

            window.setTimeout(function () { _node.setSelected(bool) }, 0);

            jQuery('#tree_1').find('span[name=\"' + _layerid + '\"]').each(function (i, span) {

                var node = jQuery.ui.fancytree.getNode(span);

                if (node.key == _node.key) { return true; }

                window.setTimeout(function () { node.setSelected(bool) }, 0);
            });

        }
        
    }
}
//(function ($) {
//    var title = "CountryEconomy"; function n() {
//        for (var o in layer_objs) {
//            layer_objs[o].marker.setMap(null);
//
//            if (layer_objs[o].circle) { layer_objs[o].circle.setMap(null) }
//        }
//        layer_objs.length = 0; rr_marker = null
//    }
//
//    $("#shpLegend").draggable({ containment: "#wrap" });
//    //$("#shpLegend").position({ my: "right-80 bottom-35", at: "right bottom", of: "#wrap" });
//    $("#shpLegend button").click(function () {
//        $("#shpLegend").hide();
//    })
//})(jQuery);

