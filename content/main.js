/**
 * Created by tahsmith on 1/3/17.
 */


function onData(context) {
    var networks = context.networks.split(',');
    var paired = context.paired !== '0';
    var error = context.error;
    networks.forEach(function (network) {
        var networkElem = $(document.createElement('li'));
        networkElem.data('network', network);
        networkElem.click(selectNetwork);
        networkElem.text(network);
        networkElem.addClass('list-group-item');
        $('#networks').append(networkElem);
    });

    if (error) {
        $('#message').text(error);
    }

    if (paired) {
        $('#code-input-group').hide();
        $('#name-input-group').hide();
    }

    $("#content-submit").css('display', 'block');

    $('#submit').click(function (event) {
        $('#submit').addClass('disabled');
        $.ajax({
            url: '/',
            data: $('#config-form').serialize(),
            success: function (data, status, jqxhr) {
                $("#content-submit").css('display', 'none');
                $("#content-pending").css('display', 'block');
            },
            error: function (jqxhr, status, error) {
                $("#modal-message")
                    .text('Could not react your Sagan. Are you still connected to the "Sagan", Wifi network?');
                $("#message-modal").modal('show');
            },
            method: 'post'
        });
        event.preventDefault();
        return false;
    });
}

window.onload = function () {
    $.getJSON('/config', null, onData);
};

function selectNetwork() {
    var network = $(this).data('network');
    $('#ssid-input').val(network);
    $('#networks-modal').modal('hide');

}