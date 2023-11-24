package com.krakedev.inventarios.bdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import com.krakedev.inventarios.entidades.Proveedor;
import com.krakedev.inventarios.entidades.TipoDocumentos;
import com.krakedev.inventarios.excepciones.KrakedevException;
import com.krakedev.inventarios.utils.ConexionBDD;

public class ProveedoresBDD {
	public ArrayList<Proveedor>buscar(String subcadena) throws KrakedevException{
		ArrayList<Proveedor> proveedores = new ArrayList<Proveedor>();
		Connection con = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		Proveedor proveedor = null;
		
		try {
			con = ConexionBDD.obtenerConexion();
			ps = con.prepareStatement("select identificador ,codigo_tipo_documento,nombre_proveedor ,telefono_proveedor ,correo_proveedor,direccion_proveedor "
					+ "from proveedores "
					+ "where upper(nombre_proveedor) like ?");
			ps.setString(1,"%"+subcadena.toUpperCase()+"%");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String identificador = rs.getString("identificador");
				String tipoDocumento = rs.getString("codigo_tipo_documento");
				String nombre = rs.getString("nombre_proveedor");
				String telefono = rs.getString("telefono_proveedor");
				String correo = rs.getString("correo_proveedor");
				String direccion = rs.getString("direccion_proveedor");
				
				proveedor = new Proveedor(identificador, tipoDocumento, nombre, telefono, correo, direccion);
				proveedores.add(proveedor);
				
			}
			
		} catch (KrakedevException e) {
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new KrakedevException("Error al consultar. Detalle : "+ e.getMessage());
		}
		
		return proveedores;
	}
	
	public ArrayList<TipoDocumentos>recuperarTodos() throws KrakedevException{
		ArrayList<TipoDocumentos> tipoDocumentos = new ArrayList<TipoDocumentos>();
		Connection con = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		TipoDocumentos tipdoc = null;
		
		try {
			con = ConexionBDD.obtenerConexion();
			ps = con.prepareStatement("select codigo_tipo_documento, descripcion from tipo_documentos ");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String codigo = rs.getString("codigo_tipo_documento");
				String descripcion = rs.getString("descripcion");
				
				
				tipdoc = new TipoDocumentos(codigo, descripcion);
				tipoDocumentos.add(tipdoc);
				
			}
			
		} catch (KrakedevException e) {
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new KrakedevException("Error al consultar. Detalle : "+ e.getMessage());
		}
		
		return tipoDocumentos;
	}
}
