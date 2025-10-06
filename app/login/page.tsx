import LoginForm from "./LoginForm";
import { requireGuest } from "@/lib/guard/auth-guard";

export default async function LoginPage() {
  await requireGuest();

  return <LoginForm />;
}