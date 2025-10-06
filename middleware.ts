import { getToken } from "next-auth/jwt";
import { NextRequest, NextResponse } from "next/server";
import { protectedRoutes } from './lib/protectedRoutes'


export async function middleware(req: NextRequest) {
  const sessionToken = req.cookies.get('next-auth.session-token')?.value;
  const url = new URL(req.url);

  // check of de huidige route beschermd is
  const isProtectedRoute = protectedRoutes.some((route) =>
    url.pathname.startsWith(route)
  );
  if (isProtectedRoute) {
    // getToken haalt automatisch de JWT token uit de cookie en decodeert het
    const token = await getToken({ req, secret: process.env.AUTH_SECRET });

    if (!token) {
      // geen token = redirect naar login
      return NextResponse.redirect(new URL("/login", req.url));
    }
  }
  return NextResponse.next();
}
export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'],
  runtime: 'nodejs'
};