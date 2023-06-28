var canpress = false

$(function () {
    function display(bool) {
        if (bool) {
            $("#background").show();
        } else {
            $("#background").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true);
                setTimeout(() => {
                    canpress = true; 
                }, 200);
                
            } else {
                display(false);
                canpress = false;
            }
        }
    })

    $("#resume").click(function () {
        $.post("http://ol-main-menu/exit", JSON.stringify({}));
        return
    })

    $("#map").click(function () {
        $.post("http://ol-main-menu/map", JSON.stringify({}));
        return
    })
    $("#quit").click(function () {
        $.post("http://ol-main-menu/quit", JSON.stringify({}));
        return
    })
    $("#settings").click(function () {
        $.post("http://ol-main-menu/settings", JSON.stringify({}));
        return
    })

    document.onkeyup = function(data) {
        if (data.which == 27 && canpress) {
            $.post("http://ol-main-menu/exit", JSON.stringify({}));
            return
        }
    };
})