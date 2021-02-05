package ar.edu.unsam.libros

import ar.edu.unsam.libros.dao.LibroRepository
import ar.edu.unsam.libros.dao.PrestamoRepository
import ar.edu.unsam.libros.domain.Libro
import ar.edu.unsam.libros.domain.Prestamo
import org.springframework.beans.factory.InitializingBean
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ar.edu.unsam.libros.domain.Persona
import ar.edu.unsam.libros.dao.PersonaRepository

@Service
class LibrosBootstrap implements InitializingBean {

	@Autowired
	PersonaRepository repoUsuarios
	
	@Autowired
	LibroRepository repoLibros
	
	@Autowired
	PrestamoRepository repoPrestamos

	def init() {
		var medina = new Persona => [
			nombre = "Medina"
			password = "Piquito"
		]
		var santos = new Persona => [
			nombre = "Santos"
			password = "Milazzo"
		]

		var elAleph = new Libro => [
			titulo = "El Aleph"
			autor = "Jorge Luis Borges"
		]
		var noHabraMasPenas = new Libro => [
			titulo = "No habrá más penas ni olvido"
			autor = "Osvaldo Soriano"
		]
		var novelaPeron = new Libro => [
			titulo = "La novela de Perón"
			autor = "Tomás Eloy Martínez"
		]

		repoUsuarios.createIfNotExists(
			new Persona => [
				nombre = "Lampone"
				password = "Betun"
			])
		medina = repoUsuarios.createIfNotExists(medina)
		santos = repoUsuarios.createIfNotExists(santos)

		elAleph = repoLibros.createIfNotExists(elAleph)
		noHabraMasPenas = repoLibros.createIfNotExists(noHabraMasPenas)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "100 años de soledad"
				autor = "Gabriel García Márquez"
			])
		novelaPeron = repoLibros.createIfNotExists(novelaPeron)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "¿Por quién doblan las campanas?"
				autor = "Ernest Hemingway"
			])

		val elAlephASantos = crearPrestamo(elAleph, santos)
		elAleph.prestar
		repoLibros.save(elAleph)
		repoPrestamos.createWhenNew(elAlephASantos)
		
		val noHabraAMedina = crearPrestamo(noHabraMasPenas, medina)
		noHabraMasPenas.prestar
		repoLibros.save(noHabraMasPenas)
		repoPrestamos.createWhenNew(noHabraAMedina)
		
		val novelaASantos = crearPrestamo(novelaPeron, santos)
		novelaPeron.prestar
		repoLibros.save(novelaPeron)
		repoPrestamos.createWhenNew(novelaASantos)
	}
	
	def void createWhenNew(PrestamoRepository repoPrestamos, Prestamo prestamo) {
		if (repoPrestamos.findByLibro(prestamo.libro) === null) {
			repoPrestamos.save(prestamo)
		}		
	}
	
	def Persona createIfNotExists(PersonaRepository repoUsuarios, Persona usuario) {
		val bdUsuario = repoUsuarios.findByNombre(usuario.nombre)
		if (bdUsuario === null) {
			repoUsuarios.save(usuario)
			usuario
		} else {
			bdUsuario
		}
	}

	def Libro createIfNotExists(LibroRepository repoLibros, Libro libro) {
		val bdLibro = repoLibros.findByTitulo(libro.titulo)
		if (bdLibro === null) {
			repoLibros.save(libro)
			libro
		} else {
			bdLibro
		}
	}
	
	def crearPrestamo(Libro _libro, Persona _persona) {
		return new Prestamo => [
			libro = _libro
			persona = _persona
		]
	}

	override afterPropertiesSet() throws Exception {
		println("************************************************************************")
		println("Running initialization")
		println("************************************************************************")
		init
	}

}
