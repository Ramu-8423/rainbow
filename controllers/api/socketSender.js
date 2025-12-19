import { getIO } from "../../socket.js";

function formatServiceDate(dateString) {
  const date = new Date(dateString);

  const today = new Date();
  const yesterday = new Date();
  yesterday.setDate(today.getDate() - 1);

  const currentYear = today.getFullYear();
  const orderYear = date.getFullYear();

  const isToday =
    date.getDate() === today.getDate() &&
    date.getMonth() === today.getMonth() &&
    orderYear === currentYear;

  const isYesterday =
    date.getDate() === yesterday.getDate() &&
    date.getMonth() === yesterday.getMonth() &&
    orderYear === currentYear;

  let hours = date.getHours();
  let minutes = date.getMinutes();
  const ampm = hours >= 12 ? "PM" : "AM";
  hours = hours % 12 || 12;
  minutes = minutes < 10 ? "0" + minutes : minutes;

  const timeFormatted = `${hours}:${minutes} ${ampm}`;

  if (isToday) return `Today, ${timeFormatted}`;
  if (isYesterday) return `Yesterday, ${timeFormatted}`;

  let dateFormatted = date.toLocaleDateString("en-IN", {
    day: "numeric",
    month: "long"
  });

  if (orderYear !== currentYear) dateFormatted += ` ${orderYear}`;

  return `${dateFormatted}, ${timeFormatted}`;
}

export function sendOrderToServicemen(servicemen, orderData) {
  const io = getIO();
  if (!io) return;

  const finalData = {
    ...orderData,
    formatted_date: formatServiceDate(orderData.time),
    service_address: orderData.service_address,
    quantity: orderData.quantity
  };

  servicemen.forEach(sm => {
    io.to("serviceman_" + sm.id).emit("new_order", {
      ...finalData,
      distance: sm.distance
    });
  });
}
