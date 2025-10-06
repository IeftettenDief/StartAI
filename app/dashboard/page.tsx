import { requireCompleted } from "@/lib/guard/auth-guard";

export default async function DashboardPage() {
  const session = await requireCompleted();

  return (
    <div style={{ padding: "2rem" }}>
      <h1>Dashboard</h1>
      <p>Welkom, {session?.user?.email}</p>
    </div>
  );
}
