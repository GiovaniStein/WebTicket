$(document).ready(function () {
    $('#cadastraFase').click(function (event) {
        event.preventDefault();
        if (valida_form_Fase() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadFase",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formFase').each(function () {
                        this.reset();
                    });
                    $("#listadeFase").load("listaFases.jsp");
                }
            });
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});

function valida_form_Fase() {
    if ((document.getElementById("faseDescricao").value === null || document.getElementById("faseDescricao").value === "")) {
        return false;
    } else {
        return true;
    }
}

function removeFase(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover essa fase?",
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
                url: '/WebTicket/acao?parametro=exFase&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover fase!", resultado, "error");
                } else {
                    swal("Fase removida com sucesso!", "", "success");
                    $("#listadeFase").load("listaFases.jsp");
                }
            });
            return false;
        }
    });
}

function editFase(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    $('#idfase').val(td[0].innerText);
    $('#faseDescricao').val(td[1].innerText);
}

