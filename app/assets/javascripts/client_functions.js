/*$("#edit-client").click(function(){
    var url = "/clients/";
    var selected = $("#client_client").val();
    if(selected != "" &&  selected != null){
        document.location = url + selected + "/edit";
    } else {
        alert ("Please select part");
        return false;
    }
});*/


function update_select(){
    $("#order_client_id").trigger("liszt:updated")
}