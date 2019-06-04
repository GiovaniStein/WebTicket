$(document).ready(function () {
    $('#cadastraMotivo').click(function (event) {
        event.preventDefault();
        if (valida_form_motivo() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadMotivo",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formMotivo').each(function () {
                        this.reset();
                    });
                    $("#listadeMotivo").load("listaMotivos.jsp");
                }
            });
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});

function valida_form_motivo() {
    if ((document.getElementById("motivoDescricao").value === null || document.getElementById("motivoDescricao").value === "")) {
        return false;
    } else {
        return true;
    }
}


function removeMotivo(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover esse motivo?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sim',
        cancelButtonText: 'Não'
    }).then(function (isConfirm) {
        if (isConfirm.value) {
            $.ajax({
                type: "GET",
                url: '/WebTicket/acao?parametro=exMotivo&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover motivo!", resultado, "error");
                } else {
                    swal("Motivo removido com sucesso!", "", "success");
                    $("#listadeMotivo").load("listaMotivos.jsp");
                }
            });
            return false;
        }
    });
}

function editMotivo(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    $('#idmotivo').val(td[0].innerText);
    $('#motivoDescricao').val(td[1].innerText);
}

