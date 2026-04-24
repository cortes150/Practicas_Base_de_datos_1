using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Windows.Forms;

namespace Gestion_Soporte
{
    public partial class Form1 : Form
    {
        DataTable dtOrdenes;
        // Variable global para los datos del inventario
        DataTable dtInventario;
        public Form1()
        {
            InitializeComponent();

            // 1. Cargas iniciales (Lo que ya tenías)
            mostrarClientes();
            mostrarOrdenes();
            mostrarInventario();
            cargarComboClientes();
            cargarClientesOrden();

            // 2. Personalizamos el título según quién entró
            this.Text = "Sistema de Soporte - Usuario: " + UsuarioSesion.nombreTecnico + " [" + UsuarioSesion.nivelAcceso + "]";

            // 3. LOGICA DE ADMINISTRADOR:
            // Si el que entró NO es administrador, borramos la pestaña de Administración
            if (UsuarioSesion.nivelAcceso != "Administrador")
            {
                // 'tabControl1' es el nombre por defecto de tu control de pestañas
                tabControl1.TabPages.Remove(tabAdmin);
            }
            else
            {
                // Si ES administrador, cargamos las tablas de gestión de personal
                mostrarTecnicos();
                mostrarCargaTrabajo();
            }
        }

        public void cargarComboClientes()
        {
            CConexion objetoConexion = new CConexion();
            string query = "SELECT id_cliente, CONCAT(nombre, ' ', apellido) AS nombreCompleto FROM Cliente";

            try
            {
                MySqlDataAdapter da = new MySqlDataAdapter(query, objetoConexion.establecerConexion());
                DataTable dt = new DataTable();
                da.Fill(dt);

                cmbClienteEquipo.DataSource = dt;
                cmbClienteEquipo.DisplayMember = "nombreCompleto";
                cmbClienteEquipo.ValueMember = "id_cliente";

                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar lista de dueños: " + ex.Message);
            }
        }

        // --- SECCIÓN DE CLIENTES ---

        private void btnGuardarCliente_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrEmpty(txtCI.Text) || string.IsNullOrEmpty(txtCorreo.Text) || string.IsNullOrEmpty(txtCelular.Text))
            {
                MessageBox.Show("Por favor, llena los campos obligatorios.");
                return;
            }

            CConexion objetoConexion = new CConexion();
            string query = "INSERT INTO Cliente (nombre, apellido, CI, celular, telefono, direccion, tipo_cliente, correo_electronico) " +
                           "VALUES (@nom, @ape, @ci, @cel, @tel, @dir, @tipo, @mail)";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                cmd.Parameters.AddWithValue("@nom", txtNombre.Text);
                cmd.Parameters.AddWithValue("@ape", txtApellido.Text);
                cmd.Parameters.AddWithValue("@ci", txtCI.Text);
                cmd.Parameters.AddWithValue("@cel", txtCelular.Text);
                cmd.Parameters.AddWithValue("@tel", txtTelefono.Text);
                cmd.Parameters.AddWithValue("@dir", txtDireccion.Text);
                cmd.Parameters.AddWithValue("@tipo", cmbTipoCliente.Text);
                cmd.Parameters.AddWithValue("@mail", txtCorreo.Text);

                cmd.ExecuteNonQuery();
                MessageBox.Show("Cliente registrado exitosamente.");

                limpiarCampos();
                mostrarClientes();
                cargarComboClientes(); // <--- Mejora: Actualiza el combo de equipos automáticamente

                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al registrar: " + ex.Message);
            }
        }

        public void limpiarCampos()
        {
            txtNombre.Clear();
            txtApellido.Clear();
            txtCI.Clear();
            txtCelular.Clear();
            txtTelefono.Clear();
            txtDireccion.Clear();
            txtCorreo.Clear();
            cmbTipoCliente.SelectedIndex = -1;
        }

        public void mostrarClientes()
        {
            CConexion objetoConexion = new CConexion();
            try
            {
                string query = "SELECT id_cliente AS 'ID', nombre AS 'Nombre', apellido AS 'Apellido', CI, celular AS 'Celular', correo_electronico AS 'Correo' FROM Cliente";
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, objetoConexion.establecerConexion());
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                dgvClientes.DataSource = dt;
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar la lista: " + ex.Message);
            }
        }

        // --- SECCIÓN DE EQUIPOS ---

        private void btnGuardarEquipo_Click(object sender, EventArgs e)
        {
            CConexion objetoConexion = new CConexion();
            string query = "INSERT INTO Equipo (nro_serie, tipo_equipo, marca, modelo, especificacion, estado_estetico, contraseña_acceso, id_cliente) " +
                           "VALUES (@serie, @tipo, @marca, @modelo, @specs, @estado, @pass, @idCli)";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                cmd.Parameters.AddWithValue("@serie", txtNroSerie.Text);
                cmd.Parameters.AddWithValue("@tipo", cmbTipoEquipo.Text);
                cmd.Parameters.AddWithValue("@marca", txtMarca.Text);
                cmd.Parameters.AddWithValue("@modelo", txtModelo.Text);
                cmd.Parameters.AddWithValue("@specs", rtxtSpecs.Text);
                cmd.Parameters.AddWithValue("@estado", rtxtEstado.Text);
                cmd.Parameters.AddWithValue("@pass", txtPassEquipo.Text);
                cmd.Parameters.AddWithValue("@idCli", cmbClienteEquipo.SelectedValue);

                cmd.ExecuteNonQuery();
                MessageBox.Show("Equipo vinculado al cliente exitosamente.");

                limpiarCamposEquipo(); // <--- Ya no dará error porque lo definimos abajo
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al registrar equipo: " + ex.Message);
            }
        }

        // Método que te faltaba definir:
        public void limpiarCamposEquipo()
        {
            txtNroSerie.Clear();
            txtMarca.Clear();
            txtModelo.Clear();
            rtxtSpecs.Clear();
            rtxtEstado.Clear();
            txtPassEquipo.Clear();
            cmbTipoEquipo.SelectedIndex = -1;
            cmbClienteEquipo.SelectedIndex = -1;
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiarCampos();
            MessageBox.Show("Campos limpiados correctamente.");
        }

        private void btnGenerarOrden_Click(object sender, EventArgs e)
        {
            // 1. Validación de seguridad (Ingeniería básica)
            if (cmbOrdenCliente.SelectedValue == null || cmbOrdenEquipo.SelectedValue == null || string.IsNullOrEmpty(rtxtFalla.Text))
            {
                MessageBox.Show("Por favor, selecciona un Cliente, un Equipo y describe la Falla.");
                return;
            }

            CConexion objetoConexion = new CConexion();

            // 2. Consulta SQL basada en tu script de MySQL
            // Nota: 'fecha_ingreso', 'diagnostico_tecnico' y 'estado_actual' usan sus valores por defecto en la DB
            string query = "INSERT INTO Orden_Servicio (id_cliente, id_equipo, id_tecnico, fecha_prometida, falla_reportada, prioridad, costo_total) " +
                           "VALUES (@idCli, @idEqui, @idTec, @fProm, @falla, @prio, @costo)";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());

                // --- Mapeo de parámetros ---

                // IDs de las Llaves Foráneas
                cmd.Parameters.AddWithValue("@idCli", cmbOrdenCliente.SelectedValue);
                cmd.Parameters.AddWithValue("@idEqui", cmbOrdenEquipo.SelectedValue);

                // ¡TRAZABILIDAD! Usamos el ID del técnico que inició sesión
                cmd.Parameters.AddWithValue("@idTec", UsuarioSesion.idTecnico);

                // Datos de la Orden
                cmd.Parameters.AddWithValue("@fProm", dtpFechaPrometida.Value.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@falla", rtxtFalla.Text);
                cmd.Parameters.AddWithValue("@prio", cmbPrioridad.Text);

                // Manejo de decimales para el costo (por si el técnico escribe con coma o punto)
                decimal costo;
                if (!decimal.TryParse(txtCosto.Text, out costo)) { costo = 0; }
                cmd.Parameters.AddWithValue("@costo", costo);

                // 3. Ejecución
                cmd.ExecuteNonQuery();

                MessageBox.Show("¡Orden de Servicio registrada exitosamente! Trazabilidad iniciada.");

                // 4. Limpieza y refresco
                limpiarCamposOrden();
                // Aquí podrías llamar a un mostrarOrdenes() si tienes un DataGridView para órdenes
                mostrarOrdenes();
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al generar la orden: " + ex.Message);
            }
        }
        public void mostrarOrdenes()
        {
            CConexion objetoConexion = new CConexion();
            string query = @"SELECT O.id_orden AS 'Nro', 
                     CONCAT(C.nombre, ' ', C.apellido) AS 'Cliente', 
                     E.modelo AS 'Equipo', 
                     O.falla_reportada AS 'Falla',
                     O.estado_actual AS 'Estado', 
                     O.prioridad AS 'Prioridad',
                     costo_total AS 'Costo'
                     FROM Orden_Servicio O
                     JOIN Cliente C ON O.id_cliente = C.id_cliente
                     JOIN Equipo E ON O.id_equipo = E.id_equipo";

            try
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, objetoConexion.establecerConexion());
                dtOrdenes = new DataTable(); // Inicializamos nuestra variable global
                adapter.Fill(dtOrdenes);

                dgvOrdenes.DataSource = dtOrdenes; // Mostramos los datos
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar órdenes: " + ex.Message);
            }
        }
        public void limpiarCamposOrden()
        {
            cmbOrdenCliente.SelectedIndex = -1;
            cmbOrdenEquipo.DataSource = null; // Se limpia porque depende del cliente
            rtxtFalla.Clear();
            txtCosto.Text = "0.00";
            cmbPrioridad.SelectedIndex = 1; // Por defecto 'Media'
            dtpFechaPrometida.Value = DateTime.Now.AddDays(2); // Sugiere 2 días a futuro
        }

        public void cargarClientesOrden()
        {
            CConexion objetoConexion = new CConexion();
            // Traemos ID y Nombre completo para que el técnico elija fácilmente
            string query = "SELECT id_cliente, CONCAT(nombre, ' ', apellido) AS nombreCompleto FROM Cliente";

            try
            {
                MySqlDataAdapter da = new MySqlDataAdapter(query, objetoConexion.establecerConexion());
                DataTable dt = new DataTable();
                da.Fill(dt);

                cmbOrdenCliente.ValueMember = "id_cliente";       // 1. Primero el ID
                cmbOrdenCliente.DisplayMember = "nombreCompleto"; // 2. Luego el Nombre
                cmbOrdenCliente.DataSource = dt;

                // Esto evita que se seleccione uno por defecto al abrir
                cmbOrdenCliente.SelectedIndex = -1;

                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar clientes en Órdenes: " + ex.Message);
            }
        }

        // ... aquí estarían tus otros botones y métodos ...

        // Bloque 1: El evento que detecta cuando cambias de cliente
        private void cmbOrdenCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            // LA CLAVE: Solo entra si el usuario tiene el foco en el control
            if (cmbOrdenCliente.Focused && cmbOrdenCliente.SelectedValue != null)
            {
                string valor = cmbOrdenCliente.SelectedValue.ToString();

                // Ya puedes quitar el MessageBox si quieres, ¡ahora solo saldrá una vez!
                // MessageBox.Show("ID detectado: " + valor); 

                int idCli;
                if (int.TryParse(valor, out idCli))
                {
                    cargarEquiposDelCliente(idCli);
                }
            }
        }

        // Bloque 2: El método que hace la consulta filtrada a MySQL
        public void cargarEquiposDelCliente(int idCli)
        {
            CConexion objetoConexion = new CConexion();
            string query = "SELECT id_equipo, CONCAT(marca, ' ', modelo, ' (', nro_serie, ')') AS infoEquipo FROM Equipo WHERE id_cliente = @id";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                cmd.Parameters.AddWithValue("@id", idCli);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                cmbOrdenEquipo.DataSource = dt;
                cmbOrdenEquipo.DisplayMember = "infoEquipo";
                cmbOrdenEquipo.ValueMember = "id_equipo";

                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al filtrar equipos: " + ex.Message);
            }
        }

        public void mostrarTecnicos()
        {
            CConexion objetoConexion = new CConexion();
            string query = "SELECT id_tecnico AS ID, nombre, apellido, ci, especialidad, nivel_acceso AS Rango FROM Tecnico";
            try
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, objetoConexion.establecerConexion());
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                dgvTecnicos.DataSource = dt;
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar técnicos: " + ex.Message);
            }
        }

        public void mostrarCargaTrabajo()
        {
            CConexion objetoConexion = new CConexion();
            // Consulta JOIN para unir técnicos con sus órdenes actuales
            string query = "SELECT T.nombre AS 'Técnico', E.modelo AS 'Equipo', O.falla_reportada AS 'Falla', O.estado_actual AS 'Estado' " +
                           "FROM Orden_Servicio O " +
                           "JOIN Tecnico T ON O.id_tecnico = T.id_tecnico " +
                           "JOIN Equipo E ON O.id_equipo = E.id_equipo " +
                           "WHERE O.estado_actual != 'Entregado'";

            try
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, objetoConexion.establecerConexion());
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                dgvCargaTrabajo.DataSource = dt;
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar carga de trabajo: " + ex.Message);
            }
        }

        private void btnLimpiarOrden_Click(object sender, EventArgs e)
        {
            limpiarCamposOrden();
            // Un mensaje pequeño para confirmar al técnico
            MessageBox.Show("Formulario de orden restablecido.");
        }

        private void btnEliminarTecnico_Click(object sender, EventArgs e)
        {
            // 1. Verificamos que haya una fila seleccionada en el DataGridView
            if (dgvTecnicos.CurrentRow == null)
            {
                MessageBox.Show("Por favor, selecciona al técnico que deseas eliminar de la lista.");
                return;
            }

            // 2. Obtenemos el ID y el Nombre para la confirmación
            // Nota: "ID" y "Nombre" deben ser los nombres de las columnas en tu dgvTecnicos
            int idEliminar = Convert.ToInt32(dgvTecnicos.CurrentRow.Cells["ID"].Value);
            string nombreTec = dgvTecnicos.CurrentRow.Cells["Nombre"].Value.ToString();

            // 3. Confirmación de seguridad (UX básica)
            DialogResult confirmacion = MessageBox.Show(
                "¿Estás seguro de que deseas eliminar a " + nombreTec + "?\nEsta acción no se puede deshacer.",
                "Confirmar Eliminación",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Warning
            );

            if (confirmacion == DialogResult.Yes)
            {
                CConexion objetoConexion = new CConexion();
                string query = "DELETE FROM Tecnico WHERE id_tecnico = @id";

                try
                {
                    MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                    cmd.Parameters.AddWithValue("@id", idEliminar);

                    cmd.ExecuteNonQuery();

                    MessageBox.Show("Técnico eliminado correctamente del sistema.");

                    // 4. Refrescamos la tabla para que ya no aparezca
                    mostrarTecnicos();

                    objetoConexion.cerrarConexion();
                }
                catch (MySqlException ex)
                {
                    // 5. Manejo de error de Integridad (Llave Foránea)
                    if (ex.Number == 1451) // Error código 1451: Restricción de llave foránea
                    {
                        MessageBox.Show("No se puede eliminar a este técnico porque tiene órdenes de servicio registradas a su nombre. Por seguridad, la trazabilidad impide borrarlo.");
                    }
                    else
                    {
                        MessageBox.Show("Error al intentar eliminar: " + ex.Message);
                    }
                }
            }
        }

        private void btnAñadirTecnico_Click(object sender, EventArgs e)
        {
            FormRegistroTecnico ventana = new FormRegistroTecnico();
            ventana.ShowDialog(); // Se abre la ventana

            // Una vez que se cierra la ventana de registro, actualizamos la tabla del Form1
            mostrarTecnicos();
        }

        private void dgvOrdenes_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // Verificamos que se haya hecho clic en una fila real y no en el encabezado
            if (e.RowIndex >= 0)
            {
                try
                {
                    var fila = dgvOrdenes.Rows[e.RowIndex];

                    // 1. Capturamos el ID (Usando el nombre de columna que sí te funciona: "Nro")
                    txtIdOrdenSeleccionada.Text = fila.Cells["Nro"].Value.ToString();
                    int idOrden = Convert.ToInt32(txtIdOrdenSeleccionada.Text);

                    // 2. Capturamos el resto de los campos
                    cmbEstadoActual.Text = fila.Cells["Estado"].Value?.ToString() ?? "";
                    rtxtFalla.Text = fila.Cells["Falla"].Value?.ToString() ?? "";

                    // --- LA CORRECCIÓN AQUÍ ---
                    // Si te sigue fallando por el nombre, usa el índice numérico de la columna del costo
                    // Por ejemplo, si es la columna 5, pon Cells[4]
                    txtCosto.Text = fila.Cells["Costo"].Value?.ToString() ?? "0.00";

                    // 3. Cargamos la tabla de repuestos usados
                    mostrarDetalleRepuestos(idOrden);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Revisa los nombres de las columnas: " + ex.Message);
                }
            }
        }

        private void btnActualizarOrden_Click(object sender, EventArgs e)
        {
            // 1. Validación inicial
            if (string.IsNullOrEmpty(txtIdOrdenSeleccionada.Text))
            {
                MessageBox.Show("Selecciona una orden de la lista primero.");
                return;
            }

            CConexion objetoConexion = new CConexion();
            string query = @"UPDATE Orden_Servicio 
                     SET falla_reportada = @falla, 
                         diagnostico_tecnico = @diag, 
                         estado_actual = @est, 
                         costo_total = @costo 
                     WHERE id_orden = @id";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                cmd.Parameters.AddWithValue("@falla", rtxtFalla.Text);
                cmd.Parameters.AddWithValue("@diag", rtxtDiagnostico.Text);
                cmd.Parameters.AddWithValue("@est", cmbEstadoActual.Text);
                cmd.Parameters.AddWithValue("@costo", Convert.ToDecimal(txtCosto.Text));
                cmd.Parameters.AddWithValue("@id", txtIdOrdenSeleccionada.Text);

                // Ejecutamos la actualización
                cmd.ExecuteNonQuery();

                // --- LÓGICA DEL HISTORIAL (Solo corre si lo de arriba no dio error) ---
                int idOrden = int.Parse(txtIdOrdenSeleccionada.Text);
                string nuevoEstado = cmbEstadoActual.Text;

                // Aquí puedes usar el ID de Beymar (1) o tu variable de sesión
                int idTecnicoActual = 1;
                string notas = rtxtDiagnostico.Text;

                // Llamamos a tu método para guardar en la tabla Historial_Estado
                registrarHistorialEstado(idTecnicoActual, idOrden, nuevoEstado, notas);

                MessageBox.Show("¡Orden actualizada e historial registrado con éxito!");

                // Refrescamos la interfaz
                mostrarOrdenes();
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al actualizar o registrar historial: " + ex.Message);
            }
        }

        private void txtBuscarOrden_TextChanged(object sender, EventArgs e)
        {
            // Verificamos que la tabla tenga datos para no dar error
            if (dtOrdenes != null)
            {
                // Creamos el filtro: busca en la columna 'Cliente' O en la columna 'Equipo'
                // El '%' sirve para que encuentre coincidencias en cualquier parte del texto
                dtOrdenes.DefaultView.RowFilter = string.Format("Cliente LIKE '%{0}%' OR Equipo LIKE '%{0}%'", txtBuscarOrden.Text);
            }
        }

        private void btnLimpiarEquipo_Click(object sender, EventArgs e)
        {
            // 1. Limpiar los cuadros de texto (TextBox)
            txtNroSerie.Clear();
            txtMarca.Clear();
            txtModelo.Clear();
            txtPassEquipo.Clear();

            // 2. Limpiar los cuadros de texto enriquecido (RichTextBox)
            rtxtSpecs.Clear();
            rtxtEstado.Clear();

            // 3. Resetear los combos (ComboBox) a su estado inicial
            cmbClienteEquipo.SelectedIndex = -1;
            cmbTipoEquipo.SelectedIndex = -1;

            // Opcional: Poner el foco en el primer campo para empezar de nuevo
            cmbClienteEquipo.Focus();

            // Mensaje opcional en la barra de estado o MessageBox
            // MessageBox.Show("Formulario de equipo restablecido.");
        }
        public void mostrarInventario()
        {
            CConexion objetoConexion = new CConexion();
            // Traemos los datos clave para el técnico
            string query = "SELECT id_repuesto AS ID, nombre_repuesto AS Nombre, marca AS Marca, stock_actual AS Stock, precio_venta AS Precio FROM Repuesto";

            try
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, objetoConexion.establecerConexion());

                // Llenamos la variable global
                dtInventario = new DataTable();
                adapter.Fill(dtInventario);

                dgvInventario.DataSource = dtInventario;

                // --- Mantenemos tu lógica de colores para stock bajo ---
                foreach (DataGridViewRow row in dgvInventario.Rows)
                {
                    if (row.Cells["Stock"].Value != null)
                    {
                        int actual = Convert.ToInt32(row.Cells["Stock"].Value);
                        // Supongamos un mínimo de 3 para la alerta visual
                        if (actual <= 3)
                        {
                            row.DefaultCellStyle.BackColor = Color.LightSalmon;
                        }
                    }
                }
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar inventario: " + ex.Message);
            }
        }

        private void label32_Click(object sender, EventArgs e)
        {

        }

        private void label33_Click(object sender, EventArgs e)
        {

        }

        private void btnGuardarRepuesto_Click(object sender, EventArgs e)
        {
            CConexion objetoConexion = new CConexion();

            // 1. Agregamos 'codigo_parte' y su parámetro '@cod' a la consulta
            string query = "INSERT INTO Repuesto (codigo_parte, nombre_repuesto, marca, categoria, precio_costo, precio_venta, stock_actual, stock_minimo) " +
                           "VALUES (@cod, @nom, @mar, @cat, @pCosto, @pVenta, @sAct, @sMin)";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());

                // 2. Mapeamos el nuevo parámetro desde el TextBox
                cmd.Parameters.AddWithValue("@cod", txtCodParte.Text);

                // El resto de tus parámetros (asegúrate que los nombres coincidan con tu DB)
                cmd.Parameters.AddWithValue("@nom", txtNomRepuesto.Text);
                cmd.Parameters.AddWithValue("@mar", txtMarcaRep.Text);
                cmd.Parameters.AddWithValue("@cat", cmbCategoria.Text);
                cmd.Parameters.AddWithValue("@pCosto", decimal.Parse(txtPrecioCosto.Text));
                cmd.Parameters.AddWithValue("@pVenta", decimal.Parse(txtPrecioVenta.Text));
                cmd.Parameters.AddWithValue("@sAct", int.Parse(txtStockActual.Text));
                cmd.Parameters.AddWithValue("@sMin", int.Parse(txtStockMinimo.Text));

                cmd.ExecuteNonQuery();
                MessageBox.Show("Repuesto registrado con éxito.");

                mostrarInventario();
                limpiarCamposInventario();
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al registrar: " + ex.Message);
            }
        }

        public void limpiarCamposInventario()
        {
            // 1. Limpiamos los cuadros de texto
            txtCodParte.Clear();
            txtNomRepuesto.Clear();
            txtMarcaRep.Clear();
            txtPrecioCosto.Clear();
            txtPrecioVenta.Clear();
            txtStockActual.Clear();
            txtStockMinimo.Clear();

            // 2. Reseteamos el combo de categorías
            cmbCategoria.SelectedIndex = -1;

            // 3. Ponemos el cursor en el primer campo para el siguiente registro
            txtNomRepuesto.Focus();
        }

        private void btnLimpiarInventario_Click(object sender, EventArgs e)
        {
            // Reutilizamos el método para no escribir el mismo código dos veces
            limpiarCamposInventario();
        }

        private void txtBuscarRepuesto_TextChanged(object sender, EventArgs e)
        {
            if (dtInventario != null)
            {
                // Filtramos por Nombre o por Marca
                dtInventario.DefaultView.RowFilter = string.Format("Nombre LIKE '%{0}%' OR Marca LIKE '%{0}%'", txtBuscarRepuesto.Text);
            }
        }

        private void btnAsignarRepuesto_Click(object sender, EventArgs e)
        {
            // 1. Validaciones de seguridad
            if (string.IsNullOrEmpty(txtIdOrdenSeleccionada.Text))
            {
                MessageBox.Show("Primero selecciona una Orden de Servicio en la otra pestaña.");
                return;
            }
            if (dgvInventario.CurrentRow == null)
            {
                MessageBox.Show("Selecciona un repuesto de la tabla.");
                return;
            }

            // 2. Capturamos los datos necesarios
            int idOrden = Convert.ToInt32(txtIdOrdenSeleccionada.Text);
            int idRep = Convert.ToInt32(dgvInventario.CurrentRow.Cells["ID"].Value);
            decimal precioVenta = Convert.ToDecimal(dgvInventario.CurrentRow.Cells["Precio"].Value);
            int stockActual = Convert.ToInt32(dgvInventario.CurrentRow.Cells["Stock"].Value);

            if (stockActual <= 0)
            {
                MessageBox.Show("No hay stock disponible de este repuesto.");
                return;
            }

            CConexion objetoConexion = new CConexion();
            MySqlConnection conexion = objetoConexion.establecerConexion();
            // Iniciamos una Transacción para que todo sea atómico (todo o nada)
            MySqlTransaction transaccion = conexion.BeginTransaction();

            try
            {
                // PASO A: Registrar en Detalle_Reparacion
                string queryDetalle = "INSERT INTO Detalle_Reparacion " +
                    "(id_orden, id_repuesto, cantidad, precio_unitario_aplicado, subtotal) " +
                                      "VALUES (@idO, @idR, @cant, @precio, @sub)";
                MySqlCommand cmdDetalle = new MySqlCommand(queryDetalle, conexion, transaccion);
                cmdDetalle.Parameters.AddWithValue("@idO", idOrden);
                cmdDetalle.Parameters.AddWithValue("@idR", idRep);
                cmdDetalle.Parameters.AddWithValue("@cant", 1); // Cantidad por defecto
                cmdDetalle.Parameters.AddWithValue("@precio", precioVenta);
                cmdDetalle.Parameters.AddWithValue("@sub", precioVenta); // Como cantidad es 1, subtotal = precio

                cmdDetalle.ExecuteNonQuery();

                // PASO B: Restar 1 al stock del Repuesto
                string queryStock = "UPDATE Repuesto SET stock_actual = stock_actual - 1 WHERE id_repuesto = @idR";
                MySqlCommand cmdStock = new MySqlCommand(queryStock, conexion, transaccion);
                cmdStock.Parameters.AddWithValue("@idR", idRep);
                cmdStock.ExecuteNonQuery();

                // PASO C: Sumar el precio al costo total de la Orden
                string queryCosto = "UPDATE Orden_Servicio SET costo_total = costo_total + @precio WHERE id_orden = @idO";
                MySqlCommand cmdCosto = new MySqlCommand(queryCosto, conexion, transaccion);
                cmdCosto.Parameters.AddWithValue("@precio", precioVenta);
                cmdCosto.Parameters.AddWithValue("@idO", idOrden);
                cmdCosto.ExecuteNonQuery();

                // Si todo salió bien, confirmamos los cambios en MySQL
                transaccion.Commit();
                MessageBox.Show("¡Repuesto cargado con éxito! Stock actualizado y costo sumado.");

                // Refrescamos las tablas para ver los cambios
                mostrarInventario();
                mostrarOrdenes();

            }
            catch (Exception ex)
            {
                // Si algo falló, deshacemos todo para no dejar datos corruptos
                transaccion.Rollback();
                MessageBox.Show("Error en la transacción: " + ex.Message);
            }
            finally
            {
                objetoConexion.cerrarConexion();
            }
        }

        public void mostrarDetalleRepuestos(int idOrden)
        {
            CConexion objetoConexion = new CConexion();
            // Usamos los nombres exactos de tu tabla: precio_unitario_aplicado y subtotal
            string query = @"SELECT R.nombre_repuesto AS 'Repuesto', 
                            D.cantidad AS 'Cant', 
                            D.precio_unitario_aplicado AS 'Precio', 
                            D.subtotal AS 'Subtotal'
                     FROM Detalle_Reparacion D
                     JOIN Repuesto R ON D.id_repuesto = R.id_repuesto
                     WHERE D.id_orden = @id";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                cmd.Parameters.AddWithValue("@id", idOrden);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Asignamos los datos al control gris
                dgvDetalleRepuestos.DataSource = dt;

                // Si la tabla sigue gris, es que dt no tiene filas.
                if (dt.Rows.Count == 0)
                {
                    Console.WriteLine("No hay repuestos para la orden: " + idOrden);
                }

                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error en dgvDetalle: " + ex.Message);
            }
        }

        public void registrarHistorialEstado(int idTec, int idOrd, string nuevoEstado, string nota)
        {
            CConexion objetoConexion = new CConexion();
            // Ajustado a tu tabla con id_tecnico y observaciones
            string query = "INSERT INTO Historial_Estado (id_tecnico, id_orden, estado, observaciones) " +
                           "VALUES (@idT, @idO, @est, @obs)";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                cmd.Parameters.AddWithValue("@idT", idTec);
                cmd.Parameters.AddWithValue("@idO", idOrd);
                cmd.Parameters.AddWithValue("@est", nuevoEstado);
                cmd.Parameters.AddWithValue("@obs", nota);

                cmd.ExecuteNonQuery();
                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al guardar en el historial: " + ex.Message);
            }
        }

        private void btnVerHistorial_Click(object sender, EventArgs e)
        {
            // 1. Faltaba la palabra 'if' y el paréntesis '(' al principio
            if (!string.IsNullOrEmpty(txtIdOrdenSeleccionada.Text))
            {
                int id = int.Parse(txtIdOrdenSeleccionada.Text);

                // 2. Creamos la instancia (Asegúrate de haber creado ya el FormHistorial)
                FormHistorial ventanaHistorial = new FormHistorial(id);

                // 3. Lo mostramos como diálogo
                ventanaHistorial.ShowDialog();
            }
            else // 4. Si el ID está vacío, mostramos el aviso
            {
                MessageBox.Show("Por favor, selecciona una orden de la lista.");
            }
        }

        public void procesarCobroFinal(int idOrd, decimal montoTotal, string metodo, string comprobante)
        {
            CConexion objetoConexion = new CConexion();
            MySqlConnection conexion = objetoConexion.establecerConexion();
            // Iniciamos la transacción
            MySqlTransaction transaccion = conexion.BeginTransaction();

            try
            {
                // A. Insertar el registro de Pago
                string queryPago = @"INSERT INTO Pago (id_orden, monto, metodo_pago, nro_comprobante) 
                             VALUES (@id, @monto, @metodo, @comp)";
                MySqlCommand cmdPago = new MySqlCommand(queryPago, conexion, transaccion);
                cmdPago.Parameters.AddWithValue("@id", idOrd);
                cmdPago.Parameters.AddWithValue("@monto", montoTotal);
                cmdPago.Parameters.AddWithValue("@metodo", metodo);
                cmdPago.Parameters.AddWithValue("@comp", comprobante);
                cmdPago.ExecuteNonQuery();

                // B. Actualizar el estado de la Orden a 'Entregado'
                string queryOrden = "UPDATE Orden_Servicio SET estado_actual = 'Entregado' WHERE id_orden = @id";
                MySqlCommand cmdOrden = new MySqlCommand(queryOrden, conexion, transaccion);
                cmdOrden.Parameters.AddWithValue("@id", idOrd);
                cmdOrden.ExecuteNonQuery();

                // C. Registrar automáticamente en el Historial
                // Usamos el ID del técnico actual y una nota de sistema
                registrarHistorialEstado(1, idOrd, "Entregado", "Equipo entregado tras pago en " + metodo);

                // Si todo llegó hasta aquí sin errores, confirmamos los cambios
                transaccion.Commit();
                MessageBox.Show("¡Cobro exitoso! La orden ha sido cerrada y el equipo marcado como Entregado.");
            }
            catch (Exception ex)
            {
                // Si algo falló (ej. se cortó la luz o internet), se deshace todo
                transaccion.Rollback();
                MessageBox.Show("Error crítico en el cobro: " + ex.Message);
            }
            finally
            {
                objetoConexion.cerrarConexion();
            }
        }

        private void btnCobrarSeleccionados_Click(object sender, EventArgs e)
        {
            if (dgvOrdenes.SelectedRows.Count == 0)
            {
                MessageBox.Show("Selecciona las órdenes que vas a cobrar (puedes usar Ctrl+Clic).");
                return;
            }

            // --- SOLUCIÓN PARA NO SATURAR LA PANTALLA ---
            // Usamos variables locales. Por ahora las fijamos, pero luego puedes 
            // crear un Form pequeño para pedirlas.
            string metodoPago = "Efectivo"; // Aquí podrías abrir un pequeño Form
            string nroRef = "S/N";

            try
            {
                foreach (DataGridViewRow fila in dgvOrdenes.SelectedRows)
                {
                    int id = Convert.ToInt32(fila.Cells["Nro"].Value);
                    decimal montoIndividual = Convert.ToDecimal(fila.Cells["Costo"].Value);

                    // Llamamos a tu función de cobro con los datos que definimos arriba
                    procesarCobroFinal(id, montoIndividual, metodoPago, nroRef);
                }

                MessageBox.Show("¡Cobro múltiple realizado! Los equipos pasaron a estado 'Entregado'.");
                mostrarOrdenes();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al procesar: " + ex.Message);
            }
        }

      

        private void btnCobrarMultiple_Click(object sender, EventArgs e)
        {
            // 1. Verificamos que haya algo seleccionado en la tabla principal
            if (dgvOrdenes.SelectedRows.Count == 0)
            {
                MessageBox.Show("Selecciona las órdenes en la tabla primero.");
                return;
            }

            decimal sumaTotal = 0;
            // Usamos una lista para guardar los IDs y sus costos
            var listaCobro = new List<KeyValuePair<int, decimal>>();

            foreach (DataGridViewRow fila in dgvOrdenes.SelectedRows)
            {
                // Asegúrate que los nombres "Nro" y "Costo" coincidan con tus columnas del DGV
                int id = Convert.ToInt32(fila.Cells["Nro"].Value);
                decimal costo = Convert.ToDecimal(fila.Cells["Costo"].Value);

                sumaTotal += costo;
                listaCobro.Add(new KeyValuePair<int, decimal>(id, costo));
            }

            // 2. Llamamos a la ventanita que creaste
            using (FormCobro ventana = new FormCobro(sumaTotal))
            {
                // Si el usuario le da al botón "Confirmar" en la ventanita
                if (ventana.ShowDialog() == DialogResult.OK)
                {
                    // 3. Procesamos cada equipo en la base de datos
                    foreach (var equipo in listaCobro)
                    {
                        // equipo.Key es el ID, equipo.Value es el Costo individual
                        procesarCobroFinal(equipo.Key, equipo.Value, ventana.MetodoSeleccionado, ventana.Referencia);
                    }

                    MessageBox.Show("¡Proceso de cobro múltiple finalizado!");
                    mostrarOrdenes(); // Refrescamos la tabla principal
                }
            }
        }

        
    }
    
}