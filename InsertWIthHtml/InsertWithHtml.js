let f = document.querySelector('#insertForm');
//console.log(f);

//javascript kod ne radi dobro u ASP.NET Web Forms zbog postojanja
// form taga u Site master-u, zato podvlaci form tag zelenom bojom na aspx stranici
//zbog toga kontrolu unosa cemo validirati na strani servera

/*
 Bootstrap klase koje koristimo ovde:
 https://getbootstrap.com/docs/4.0/components/forms/
 */


f.addEventListener('submit', function (ev) {

    //console.log("DEBUG000");

    const greska = document.querySelector('#error');

    let lastNameField = document.querySelector('#LastName');
    let lastName = lastNameField.value.trim();

    

    if (lastName === '') {

        //console.log("DEBUG0");

        greska.textContent = 'Insert last name!';

        lastNameField.focus();

        //console.log("DEBUG1");

        //dodajemo Bootstrap klasu kojom pocrveni input jer nista nije uneto
        lastNameField.classList.add("is-invalid");

        //console.log("DEBUG2");

        ev.preventDefault();

        return false;
        
    }

    /*ovde znamo da je u input nesto uneto i zato oduzimamo
     klasu koja crveni input i dodajemo klasu koja zeleni input*/

    lastNameField.classList.remove("is-invalid");
    lastNameField.classList.add("is-valid");
    //lastNameField.className += "is-valid";

    let firstNameField = document.querySelector('#FirstName');
    let firstName = firstNameField.value.trim();

    if (firstName === '') {

        greska.textContent = 'Insert first name!';

        firstNameField.focus();

        firstNameField.classList.add("is-invalid");

        ev.preventDefault();

        return false;
        
    }

    

    firstNameField.classList.remove("is-invalid");
    firstNameField.classList.add("is-valid");

    let yearField = document.querySelector('#Year');
    let year = yearField.value.trim();
    //console.log(typeof year);

    if (year != "1" && year != "2" && year != "3" && year != "4") {

        greska.textContent = 'Insert year!';

        yearField.focus();

        yearField.classList.add("is-invalid");

        ev.preventDefault();

        return false;
        
    }

    /*TODO
     input-i koji su tacni a ispod su pogresnih ne pozelene
     nego ostanu crveni, kako vrsiti proveru od pozadi???
     */

    yearField.classList.remove("is-invalid");
    yearField.classList.add("is-valid");

        return true;
   
});