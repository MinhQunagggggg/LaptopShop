/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
$(document).ready(function () {
    $("#searchForm").submit(function (event) {
        event.preventDefault(); // Prevent page reload
        
        var txtSearch = $("#searchQuery").val().trim();
        
        if (txtSearch === "") {
            console.log("🔄 Empty search query, reloading page...");
            location.reload();
            return;
        }

        console.log("🔍 Searching for:", txtSearch);

        $.ajax({
            url: "search", // Calls the SearchServlet
            type: "GET",
            data: { query: txtSearch },
            dataType: "html",
            success: function (data) {
                console.log("✅ AJAX Request Success!");
                $("#searchResults").html(data).fadeIn(); // Update UI
            },
            error: function (xhr) {
                console.error("❌ AJAX Error:", xhr);
                $("#searchResults").html("<p class='text-danger'>Search failed. Try again.</p>");
            }
        });
    });
});


