from flask import Flask, render_template, request, redirect, url_for, session, flash, make_response
from flask_mysqldb import MySQL
from flask_bcrypt import Bcrypt

app = Flask(__name__)
app.secret_key = 'tu_clave_secreta'

# Configuración de la base de datos MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'login_flask'

mysql = MySQL(app)
bcrypt = Bcrypt(app)

# Configuración de cabeceras para evitar que se guarde el historial (caché) al cerrar sesión
def add_no_cache_headers(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response

# --- RUTAS ---

@app.route('/')
def index():
    if 'username' in session:
        return redirect(url_for('home'))
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Buscar usuario en la base de datos
        cur = mysql.connection.cursor()
        cur.execute('SELECT password FROM usuarios WHERE username = %s', [username])
        resultado = cur.fetchone()
        cur.close()

        if resultado and bcrypt.check_password_hash(resultado[0], password):
            session['username'] = username
            return redirect(url_for('home'))
        else:
            flash('Usuario o contraseña incorrectos')
            return redirect(url_for('login'))

    response = make_response(render_template('login.html'))
    return add_no_cache_headers(response)

@app.route('/registrar', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Encriptar la contraseña
        password_encriptada = bcrypt.generate_password_hash(password).decode('utf-8')

        # Guardar en la base de datos
        cur = mysql.connection.cursor()
        try:
            cur.execute('INSERT INTO usuarios (username, password) VALUES (%s, %s)', (username, password_encriptada))
            mysql.connection.commit()
            flash('Usuario registrado con éxito. Ya puedes iniciar sesión.')
            return redirect(url_for('login'))
        except:
            flash('Ese nombre de usuario ya existe')
            return redirect(url_for('register'))
        finally:
            cur.close()

    return render_template('register.html')

@app.route('/home')
def home():
    # Protección de ruta: Si no hay sesión, manda al login
    if 'username' not in session:
        return redirect(url_for('login'))
        
    response = make_response(render_template('home.html'))
    return add_no_cache_headers(response)

@app.route('/logout')
def logout():
    # Limpia la sesión
    session.pop('username', None)
    flash('Has cerrado sesión correctamente.')
    return redirect(url_for('login'))

# --- EJECUCIÓN ---

if __name__ == '__main__':
    app.run(debug=True)