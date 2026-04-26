// Product Management System - Client Side Validation

function validateProductForm() {
    let isValid = true;
    
    // Get form values
    let productId = document.getElementById('productId').value;
    let productName = document.getElementById('productName') ? document.getElementById('productName').value : '';
    let category = document.getElementById('category') ? document.getElementById('category').value : '';
    let price = document.getElementById('price') ? document.getElementById('price').value : '';
    let quantity = document.getElementById('quantity') ? document.getElementById('quantity').value : '';
    
    // Clear previous errors
    clearErrors();
    
    // Validate Product ID
    if (!productId || productId <= 0) {
        showError('productIdError', 'Product ID must be a positive number');
        isValid = false;
    }
    
    // Validate Product Name
    if (productName && (!productName.trim() || productName.trim().length < 2)) {
        showError('productNameError', 'Product name must be at least 2 characters');
        isValid = false;
    }
    
    // Validate Category
    if (category && !category) {
        showError('categoryError', 'Please select a category');
        isValid = false;
    }
    
    // Validate Price
    if (price && (price < 0 || isNaN(price))) {
        showError('priceError', 'Please enter a valid price (>= 0)');
        isValid = false;
    }
    
    // Validate Quantity
    if (quantity && (quantity < 0 || isNaN(quantity))) {
        showError('quantityError', 'Please enter a valid quantity (>= 0)');
        isValid = false;
    }
    
    return isValid;
}

function showError(elementId, message) {
    let errorSpan = document.getElementById(elementId);
    if (errorSpan) {
        errorSpan.innerHTML = message;
        errorSpan.style.color = '#e74c3c';
        errorSpan.style.fontSize = '12px';
        errorSpan.style.marginTop = '5px';
        errorSpan.style.display = 'block';
    }
}

function clearErrors() {
    let errorElements = ['productIdError', 'productNameError', 'categoryError', 'priceError', 'quantityError'];
    for (let i = 0; i < errorElements.length; i++) {
        let element = document.getElementById(errorElements[i]);
        if (element) {
            element.innerHTML = '';
        }
    }
}

function validateSearchForm() {
    let searchId = document.getElementById('searchId').value;
    if (!searchId || searchId <= 0) {
        alert('Please enter a valid Product ID to search');
        return false;
    }
    return true;
}

function confirmDelete(productId, productName) {
    return confirm('Are you sure you want to delete product: ' + productName + ' (ID: ' + productId + ')?');
}