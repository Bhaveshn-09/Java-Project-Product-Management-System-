// Product Management System Validation

function validateProductForm() {

    let isValid = true;

    clearErrors();

    let productName =
        document.getElementById("productName").value;

    let category =
        document.getElementById("category").value;

    let price =
        document.getElementById("price").value;

    let quantity =
        document.getElementById("quantity").value;

    // Product Name

    if (productName.trim().length < 2) {

        showError(
            "productNameError",
            "Enter valid product name"
        );

        isValid = false;
    }

    // Category

    if (category === "") {

        showError(
            "categoryError",
            "Select category"
        );

        isValid = false;
    }

    // Price

    if (price === "" || price < 0) {

        showError(
            "priceError",
            "Enter valid price"
        );

        isValid = false;
    }

    // Quantity

    if (quantity === "" || quantity < 0) {

        showError(
            "quantityError",
            "Enter valid quantity"
        );

        isValid = false;
    }

    return isValid;
}

function showError(id, message) {

    document.getElementById(id).innerHTML = message;
}

function clearErrors() {

    let errors = document.getElementsByClassName("error");

    for (let i = 0; i < errors.length; i++) {

        errors[i].innerHTML = "";
    }
}