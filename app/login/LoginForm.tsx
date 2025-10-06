"use client";

import { useState } from "react";
import { signIn } from "next-auth/react";

export default function LoginForm() {
  const [email, setEmail] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const result = await signIn("email", {
      email,
      redirect: false,
      callbackUrl: "/dashboard",
    });

    if (result?.ok) setMessage("Check je e-mail voor de Magic Link!");
    else setMessage("Er ging iets mis, probeer opnieuw.");
  };

  return (
    <form onSubmit={handleSubmit} style={{ maxWidth: 400, margin: "auto", padding: "2rem" }}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Jouw e-mail"
        required
        style={{ width: "100%", padding: "0.5rem", marginBottom: "1rem" }}
      />
      <button type="submit" style={{ width: "100%", padding: "0.5rem" }}>
        Stuur Magic Link
      </button>
      {message && <p>{message}</p>}
    </form>
  );
}