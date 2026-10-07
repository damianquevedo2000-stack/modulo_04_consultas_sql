/*/ Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
 * Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá 
 * por mes con MONTH(fecha_venta) (en PostgreSQL sería EXTRACT(MONTH FROM fecha_venta)).
 */ 

select sum(cantidad * precio_unitario)as total_facturado,
(select AVG(cantidad * precio_unitario) from ventas)as ticket_promedio,
(select count(distinct id_venta) from ventas) as cantidad_de_pedidos
 from ventas;

/*/Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando 
 las unidades vendidas (SUM(cantidad)) y el total generado. Usá GROUP BY id_producto, ORDER BY y TOP 5 */

select id_producto,sum(cantidad * precio_unitario) as total_vendido , sum(cantidad) total_unidades_vendidas 
from ventas
group by id_producto
order by total_vendido desc
limit 5; 

/*/Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando
 la cantidad de pedidos y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) > 1 */

select * from ventas;
select id_cliente, count(id_venta) as cantidad_de_ventas from ventas
group by id_cliente
having cantidad_de_ventas >1;



