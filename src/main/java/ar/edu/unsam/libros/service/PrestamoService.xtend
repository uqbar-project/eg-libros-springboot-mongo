package ar.edu.unsam.libros.service

import ar.edu.unsam.libros.dao.LibroRepository
import ar.edu.unsam.libros.dao.PrestamoRepository
import ar.edu.unsam.libros.domain.Prestamo
import ar.edu.unsam.libros.errorHandling.NotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class PrestamoService {

	@Autowired
	PrestamoRepository prestamoRepository
	
	@Autowired
	LibroRepository libroRepository
	
	def void generarPrestamo(Prestamo prestamo) {
		val libro = libroRepository.findById(prestamo.libro.id).orElseThrow([ new NotFoundException("El libro con id " + prestamo.libro.id + " no existe" )])
		prestamo.libro = libro
		prestamo.validar
		prestamoRepository.save(prestamo)
		libro.prestar
		libroRepository.save(libro)
	}
	
	def getPrestamosPendientes() {
		prestamoRepository.getPrestamosPendientes
	}
	
	def devolverPrestamo(ar.edu.unsam.libros.domain.Prestamo prestamoOrigen) {
		val prestamo = prestamoRepository.findById(prestamoOrigen.id).orElseThrow([ new NotFoundException("El préstamo con id " + prestamoOrigen.id + " no existe" )])
		val libro = libroRepository.findById(prestamo.libro.id).orElseThrow([ new NotFoundException("El libro con id " + prestamo.libro.id + " no existe" )])
		prestamo.libro = libro
		prestamo.validarDevolucion
		prestamo.devolver
		prestamoRepository.save(prestamo)
		libroRepository.save(libro)
	}
	
}