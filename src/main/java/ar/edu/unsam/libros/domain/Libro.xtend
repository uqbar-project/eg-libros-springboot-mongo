package ar.edu.unsam.libros.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document

@Accessors
@Document(collection = "libros")
class Libro {
	public static String PRESTADO = "P"
	public static String DISPONIBLE = "D"
	
	@Id String id
	
	String titulo
	String autor
	boolean activo
	String estado // "P" prestado / "D" disponible
	
	new() {
		activo = true
		estado = DISPONIBLE
	}
	
	def void prestar(Prestamo prestamo) {
		estado = PRESTADO
	}
	
	def void devolver() {
		estado = DISPONIBLE
	}
	
	def getEstaDisponible() {
		activo && estado.equalsIgnoreCase(DISPONIBLE)
	}
	
	def estaPrestado() {
		activo && estado.equalsIgnoreCase(PRESTADO)
	}
	
	override toString() {
		titulo
	}
	
}