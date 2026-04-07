let isLogin = true;

const form = document.getElementById("form");
const toggleBtn = document.getElementById("toggle-btn");
const toggleText = document.getElementById("toggle-text");
const nombreGroup = document.getElementById("nombre-group");
const title = document.getElementById("title");
const subtitle = document.getElementById("subtitle");

// Cambiar modo
toggleBtn.addEventListener("click", () => {
    isLogin = !isLogin;

    if (isLogin) {
        title.innerText = "Iniciar Sesión";
        subtitle.innerText = "Ingresa tus datos";
        toggleText.innerText = "¿No tienes cuenta?";
        toggleBtn.innerText = "Regístrate";
        nombreGroup.style.display = "none";
    } else {
        title.innerText = "Registrarse";
        subtitle.innerText = "Crea una cuenta";
        toggleText.innerText = "¿Ya tienes cuenta?";
        toggleBtn.innerText = "Inicia sesión";
        nombreGroup.style.display = "block";
    }
});

// Enviar formulario
form.addEventListener("submit", function(e) {
    e.preventDefault();

    let email = document.getElementById("email").value;
    let password = document.getElementById("password").value;
    let nombre = document.getElementById("nombre").value;

    let url = isLogin ? "login.php" : "register.php";

    fetch(url, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ email, password, nombre })
    })
    .then(res => res.json())
    .then(data => {
        const alertBox = document.getElementById("alert-container");

        alertBox.classList.remove("hidden");
        alertBox.innerText = data.message;

        if (data.message.includes("correcto") || data.message.includes("exitoso")) {
            alertBox.className = "alert success";

            if (isLogin) {
                document.getElementById("auth-view").classList.add("hidden");
                document.getElementById("dashboard-view").classList.remove("hidden");
                document.getElementById("display-username").innerText = email;
            }

        } else {
            alertBox.className = "alert error";
        }
    });
});

// Logout
document.getElementById("logout-btn").addEventListener("click", () => {
    document.getElementById("dashboard-view").classList.add("hidden");
    document.getElementById("auth-view").classList.remove("hidden");
});