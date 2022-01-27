SELECT *
  FROM invoices;

SELECT *
  FROM invoice_items;

SELECT *
  FROM customers;

SELECT *
  FROM tracks;

SELECT *
  FROM employees;

SELECT *
  FROM albums;

SELECT sum(invoices.Total) 
  FROM invoices;/* SELECT *
  FROM albums
 WHERE albums.Title = "And Justice For All";
 
select SUM(invoices.Total), employees.FirstName
from employees INNER JOIN customers
on employees.EmployeeId = customers.SupportRepId INNER JOIN invoices
on customers.CustomerId = invoices.CustomerId
group by employees.FirstName;

/*
SELECT invoices.InvoiceId, invoice_items.UnitPrice, sum(invoice_items.Quantity), invoices.Total
FROM tracks inner join invoice_items
on tracks.TrackId = invoice_items.TrackId INNER JOIN invoices
on invoice_items.InvoiceId = invoices.InvoiceId INNER join customers
on invoices.CustomerId = customers.CustomerId INNER JOIN employees
on customers.SupportRepId = employees.EmployeeId
where employees.LastName like "Johnson"
group by invoices.InvoiceId
/*
order by invoices.InvoiceId; */
-- 1)-- ********************************************************************************************-- Consulte todas las facturas vendidas, mostrando:-- El id de la factura-- Los Albums que se vendieron por factura-- El artista del Album-- El empleado que registró la factura-- El tipo de Empleado que lo vendió-- Ordene de forma ascendente de acuerdo al Id de la Factura (De las más antigua a la más nueva)-- Tablas usadas: Employees, Customers, Invoices, Invoices_Item, Albums, Tracks, Artists
SELECT invoices.InvoiceId AS [ID Factura],
       employees.LastName || " " || employees.FirstName AS Empleado,
       artists.Name AS Artista,
       albums.Title AS Album,
       employees.Title AS [Tipo de Empleado]
  FROM employees
       INNER JOIN
       customers ON employees.EmployeeId = customers.SupportRepId
       INNER JOIN
       invoices ON customers.CustomerId = invoices.CustomerId
       INNER JOIN
       invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
       INNER JOIN
       tracks ON invoice_items.TrackId = tracks.TrackId
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
 ORDER BY (invoices.InvoiceId) ASC;
 -- ********************************************************************************************
-- 2)-- CONSULTE LAS PISTAS QUE HAN COMPRADO LOS DIFERENTES CLIENTES, ADEMÁS DEL PRECIO UNITARIO,
-- LA CANTIDAD DE VECES COMPRADO Y EL TODAL DE DINERO QUE SE HA GASTADO EN ESA PISTA
-- ADEMÁS QUE SE DETALLE EL ALBÚM, EL GENERO, EL MEDIA TYPE A LA QUE PERTENECE DICHA PISTA.
-- Tablas usadas: Customer, Invoices, Invoices_Item, Albums, Tracks, Artists, MediaTypes y Genres
SELECT customers.FirstName || " " || customers.LastName AS CLIENTES,
       invoice_items.UnitPrice AS PRECIO_UNIDAD,
       COUNT(invoice_items.Quantity) AS CANTIDAD,
       SUM(invoice_items.UnitPrice) AS TOTAL,
       albums.Title AS TITULO_ALBUM,
       tracks.Name AS NOMBRE_PISTA,
       genres.Name AS GENERO_PISTA,
       media_types.Name AS TIPO_MEDIO
  FROM customers
       INNER JOIN
       invoices ON customers.CustomerId = invoices.CustomerId
       INNER JOIN
       invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
       INNER JOIN
       tracks ON invoice_items.TrackId = tracks.TrackId
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
       INNER JOIN
       genres ON tracks.GenreId = genres.GenreId
       INNER JOIN
       media_types ON tracks.MediaTypeId = tracks.MediaTypeId
 GROUP BY TITULO_ALBUM
 -- HAVING SUM(invoice_items.UnitPrice) > 100
 ORDER BY CLIENTES;
 -- ////////////////////////////////////////////////////////////////////////////////////////////
-- ********************************************************************************************
-- 3) Mostrar un registro total donde se visualice :
-- El empleado-- Cuantas veces vendió un album
-- El artista del album
SELECT employees.LastName || " " || employees.FirstName AS Empleado,
       artists.Name AS Artista,
       albums.Title AS Album,
       Count(albums.Title) 
  FROM employees
       INNER JOIN
       customers ON employees.EmployeeId = customers.SupportRepId
       INNER JOIN
       invoices ON customers.CustomerId = invoices.CustomerId
       INNER JOIN
       invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
       INNER JOIN
       tracks ON invoice_items.TrackId = tracks.TrackId
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
 GROUP BY artists.Name,
          employees.LastName,
          albums.Title
 ORDER BY albums.Title;
 -- ////////////////////////////////////////////////////////////////////////////////////////////
-- 4) Mostrar cuanto dinero vendió cada empleado por Album y mostrar el artista del album
SELECT employees.LastName || " " || employees.FirstName AS Empleado,
       artists.Name AS Artista,
       SUM(invoices.Total) AS Venta,
       albums.Title AS Album
  FROM employees
       INNER JOIN
       customers ON employees.EmployeeId = customers.SupportRepId
       INNER JOIN
       invoices ON customers.CustomerId = invoices.CustomerId
       INNER JOIN
       invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
       INNER JOIN
       tracks ON invoice_items.TrackId = tracks.TrackId
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
 GROUP BY artists.Name,
          Empleado,
          albums.Title
 ORDER BY albums.Title;
 -- 5)GENERAR UNA CONSULTA QUE ME MUESTRE LAS FACTURAS ENTRE LAS FECHAS '2011-01-01' y '2011-12-31'
-- Y QUE ADEMÁS ME MUESTRE EL NOMBRE DEL CLIENTE, LAS PISTAS, EL ALBUM, EL ARTISTA, EL GENERO Y EL MEDIA_TYPE
SELECT *
  FROM invoices;

SELECT invoices.InvoiceId AS [ID FACTURA],
       invoices.InvoiceDate AS [FECHA FACTURA],
       SUM(invoices.Total) AS [TOTAL FACTURA],
       customers.FirstName || " " || customers.LastName AS CLIENTES,
       tracks.Name AS [NOMBRE PISTA],
       albums.Title AS [TITULO ALBUM],
       artists.Name AS ARTISTA,
       genres.Name AS GENERO,
       media_types.Name AS [MEDIA TYPE]
  FROM customers
       INNER JOIN
       invoices ON customers.CustomerId = invoices.CustomerId
       INNER JOIN
       invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
       INNER JOIN
       tracks ON tracks.TrackId = invoice_items.TrackId
       INNER JOIN
       albums ON albums.AlbumId = tracks.AlbumId
       INNER JOIN
       artists ON artists.ArtistId = albums.ArtistId
       INNER JOIN
       genres ON genres.GenreId = tracks.GenreId
       INNER JOIN
       media_types ON media_types.MediaTypeId = tracks.MediaTypeId
 WHERE invoices.InvoiceDate BETWEEN '2011-01-01' AND '2011-12-31'
 GROUP BY invoices.InvoiceId
 ORDER BY invoices.InvoiceDate ASC;
 -- 6) Consulte las 10 pistas que más generaron ingresos, adicional muestre:
-- La cantidad de veces que se compró esa pista
-- El total de dinero que generó
-- El album al que pertenece
-- El artista al que pertenece el Album
-- El genero al que pertenece la pista
-- El tipo de multimedia que tiene la pista
SELECT tracks.Name AS Pista,
       Count(invoices.InvoiceId) "Cantidad de Compras",
       round(SUM(invoice_items.UnitPrice), 2) AS Total,
       albums.Title AS Album,
       artists.Name AS Artista,
       genres.Name AS Género,
       media_types.Name AS MediaType
  FROM tracks
       INNER JOIN
       invoice_items ON tracks.TrackId = invoice_items.TrackId
       INNER JOIN
       invoices ON invoice_items.InvoiceId = invoices.InvoiceId
       INNER JOIN
       albums ON tracks.AlbumId = Albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
       INNER JOIN
       genres ON tracks.GenreId = genres.GenreId
       INNER JOIN
       media_types ON tracks.MediaTypeId = media_types.MediaTypeId
 GROUP BY invoices.InvoiceId
 ORDER BY SUM(invoices.Total) DESC
 LIMIT 10;
 -- 7) Consulte todas las pistas que existen en la base de datos, adicional muestre:
-- El Album al que pertenece cada pista
-- El artista de la Pista
-- El género
-- El mediaType
-- Al menos una playlist a la que pertenezca
SELECT tracks.Name AS Pista,
       albums.Title AS Album,
       artists.Name AS Artista,
       genres.Name AS Genero,
       media_types.Name AS MediaType,
       playlists.Name AS Playlist
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = Albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
       INNER JOIN
       genres ON tracks.GenreId = genres.GenreId
       INNER JOIN
       media_types ON tracks.MediaTypeId = media_types.MediaTypeId
       INNER JOIN
       playlist_track ON tracks.TrackId = playlist_track.TrackId
       INNER JOIN
       playlists ON playlist_track.PlaylistId = playlists.PlaylistId
 GROUP BY tracks.Name;
 -- 8) Consulte todas las pistas que existen en un album, adicional muestre:
-- El artista de la Pista
-- El género
-- El mediaType
-- Al menos una playlist a la que pertenezca
SELECT tracks.Name AS Pista,
       albums.Title AS Album,
       artists.Name AS Artista,
       genres.Name AS Genero,
       media_types.Name AS MediaType,
       playlists.Name AS Playlist
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = Albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
       INNER JOIN
       genres ON tracks.GenreId = genres.GenreId
       INNER JOIN
       media_types ON tracks.MediaTypeId = media_types.MediaTypeId
       INNER JOIN
       playlist_track ON tracks.TrackId = playlist_track.TrackId
       INNER JOIN
       playlists ON playlist_track.PlaylistId = playlists.PlaylistId
 WHERE albums.Title LIKE "A Matter of Life and Death"
 GROUP BY tracks.Name;
 -- 9) Consulte cuantas pistas tiene cada album, adicional a esto:
-- ordene de mayor a menor un top 10 de acuerdo a la cantidad de pistas
-- El artista de la Pista
-- El género
-- El mediaType
-- Al menos una playlist a la que pertenezca
SELECT Count(tracks.Name) AS Pista,
       albums.Title AS Album,
       artists.Name AS Artista,
       genres.Name AS Genero,
       media_types.Name AS MediaType,
       playlists.Name AS Playlist
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = Albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
       INNER JOIN
       genres ON tracks.GenreId = genres.GenreId
       INNER JOIN
       media_types ON tracks.MediaTypeId = media_types.MediaTypeId
       INNER JOIN
       playlist_track ON tracks.TrackId = playlist_track.TrackId
       INNER JOIN
       playlists ON playlist_track.PlaylistId = playlists.PlaylistId
 GROUP BY albums.Title
 ORDER BY Count(tracks.Name) DESC
 LIMIT 10;
 -- 10) Seleccione las ventas por cada genero de cada empleado, adicional muestre:
-- El género
-- El MediaType
-- Total Ventas por género
-- Cantidad ventas por género
SELECT employees.LastName || " " || employees.FirstName AS Empleado,
       genres.Name AS Género,
       media_types.Name AS MediaType,
       ROUND(SUM(invoices.Total), 2) AS [Total Ventas por género],
       Count(genres.Name) AS [Cantidad ventas por género]
  FROM employees
       INNER JOIN
       customers ON employees.EmployeeId = customers.SupportRepId
       INNER JOIN
       invoices ON customers.CustomerId = invoices.CustomerId
       INNER JOIN
       invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
       INNER JOIN
       tracks ON invoice_items.TrackId = tracks.TrackId
       INNER JOIN
       genres ON tracks.GenreId = genres.GenreId
       INNER JOIN
       media_types ON tracks.MediaTypeId = media_types.MediaTypeId
 GROUP BY Empleado,
          genres.Name
 ORDER BY genres.Name;
