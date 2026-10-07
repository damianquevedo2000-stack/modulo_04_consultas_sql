/*/ Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
 * Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá 
 * por mes con MONTH(fecha_venta) (en PostgreSQL sería EXTRACT(MONTH FROM fecha_venta)).
 */ 


SELECT MONTH(fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(DISTINCT id_venta) AS cantidad_pedidos,
AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

/*/Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando 
 las unidades vendidas (SUM(cantidad)) y el total generado. Usá GROUP BY id_producto, ORDER BY y TOP 5 */

select id_producto,sum(cantidad * precio_unitario) as total_vendido , sum(cantidad) total_unidades_vendidas 
from ventas
group by id_producto
order by total_vendido desc
limit 5; 

/*/Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando
 la cantidad de pedidos y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) > 1 */



SELECT 
 id_cliente, 
COUNT(id_venta) AS cantidad_pedidos,
SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1;




/*/Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional que etiquete 
con CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general. */

select month(fecha_venta) as mes, sum(cantidad * precio_unitario) as total_facturado,
case when sum(cantidad * precio_unitario) > (select avg(total_mes) 
from (select sum(cantidad * precio_unitario) as total_mes from ventas 
group by month(fecha_venta)) as sub)
then 'Por encima' else 'Por debajo' end as estado from ventas group by month(fecha_venta) order by mes;

