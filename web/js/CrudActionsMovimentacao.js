
// Via JQuery
$(document).ready(function () {
    $('#cadastraMovimentacao').click(function (event) {
        event.preventDefault();
        var values = $('#cadMovimentacao').serialize();


        var id = $('#idTarefa').val();

        var movimentacao = $('#editorMovimentacao').val();


        var v = "movimentacao=" + movimentacao + "" + "&idTarefa=" + id;
        console.log('values ', v);
        if (valida_form() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadMovimentacao",
                data: v
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#cadMovimentacao').each(function () {
                        this.reset();
                    });
                    var modal = document.getElementById('myModal');
                    $('#listaMovimentacoes').load('listaMovimentacoes.jsp', {"id": id});
                    document.getElementsByClassName("close")[0].click();


                }
            });
            return false;

        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});

function valida_form() {
    if ((document.getElementById("editorMovimentacao").value === null || document.getElementById("editorMovimentacao").value === "")) {
        return false;

    } else {
        return true;
    }
}


