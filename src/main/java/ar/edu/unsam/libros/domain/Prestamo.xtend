package ar.edu.unsam.libros.domain

import ar.edu.unsam.libros.UserException
import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document

@Accessors
@Document(collection = "prestamos")
class Prestamo {
	@Id String id
	Persona persona
	Libro libro
	LocalDate fechaPrestamo = LocalDate.now
	LocalDate fechaDevolucion

	def estaPendiente() {
		fechaDevolucion === null
	}
	
	def void validar() {
		if (libro === null) {
			throw new UserException("Debe seleccionar el libro a prestar")
		}
		if (persona === null) {
			throw new UserException("Debe seleccionar a quién prestarle el libro")
		}
		if (!libro.estaDisponible) {
			throw new UserException("El libro no está disponible")
		}
	}

	def validarDevolucion() {
		if (estaDisponible) {
			throw new UserException("El préstamo del libro ya terminó")
		}
		if (libro.estaDisponible) {
			throw new UserException("El libro ya fue devuelto")
		}
	}
	
	def devolver() {
		fechaDevolucion = LocalDate.now
		libro.devolver
	}
	
	def estaDisponible() {
		!estaPendiente
	}

	override toString() {
		"" + super.hashCode() + "- " + libro.toString() + " a " + persona.toString
	}
	
}