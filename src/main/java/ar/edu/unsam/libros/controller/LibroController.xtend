package ar.edu.unsam.libros.controller

import ar.edu.unsam.libros.dao.LibroRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins = "*")
class LibroController {

	@Autowired
	LibroRepository libroRepository

	@GetMapping("/libros/{valorABuscar}")
	def getLibrosPrestables(@PathVariable String valorABuscar) {
		this.libroRepository.getLibrosPrestables(valorABuscar)
	}

}
