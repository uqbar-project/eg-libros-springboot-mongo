package ar.edu.unsam.libros.controller

import ar.edu.unsam.libros.dao.LibroRepository
import io.swagger.annotations.ApiOperation
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
	@ApiOperation("Recupera información de los libros cuyo título contiene el valor a buscar (campo obligatorio). No distingue mayúsculas / minúsculas, por lo que si se busca 'prin' devolverá por ejemplo el libro que tiene como título 'El Principito'.")
	def getLibrosPrestables(@PathVariable String valorABuscar) {
		this.libroRepository.getLibrosPrestables(valorABuscar)
	}

}
